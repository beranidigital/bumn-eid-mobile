import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/pk_item_company.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_detailed/di/pk_company_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_detailed/pk_company_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class PKCompanyDetailedPage extends StatefulWidget with InjectableWidget {
  final PKCompanyDetailedPageGraph _graph;

  final String companyId;

  //injected
  ColorPalette colorPalette;
  //injected
  PKCompanyDetailedActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  PKCompanyDetailedPageGraph graph() => _graph;

  PKCompanyDetailedPage(
      {@required this.companyId, PKCompanyDetailedPageGraph graph})
      : this._graph = graph ?? PKCompanyDetailedPageGraph() {
    setup();
  }

  @override
  _PKCompanyDetailedPageState createState() => _PKCompanyDetailedPageState();
}

class _PKCompanyDetailedPageState extends State<PKCompanyDetailedPage>
    with AfterLayoutMixin<PKCompanyDetailedPage> {
  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);
  List<PkItemCompany> data;
  Map<String, PkItemCompany> filteredData;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      List<PkItemCompany> companiesList = await widget.csrController
          .fetchPkItemByCompany(companyId: widget.companyId);
      if (companiesList.isEmpty) throw Exception();

      setState(() {
        this.data = companiesList;
      });

      processData();
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  void processData() {
    Map<String, PkItemCompany> categorizedCompanies = {};
    data.forEach((company) {
      if (company.getTahun() != currentTahun) return;
      categorizedCompanies[company.getPropinsi()] = company;
    });

    setState(() {
      this.filteredData = categorizedCompanies;
    });
  }

  Widget mapWidget(BuildContext context) {
    return Container(
      height: 200.0,
      child: GoogleMap(
        initialCameraPosition: Constants.indonesiaCameraPosition,
        markers: filteredData.values
            .map((item) => Marker(
                  markerId: MarkerId(item.getPropinsi()),
                  position: item.getLatLng(),
                  infoWindow: InfoWindow(
                      title: item.getPropinsi(),
                      snippet:
                          "Jumlah: ${formatNumber(item.getTotal() / Constants.billion)} Miliar"),
                ))
            .toSet(),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
      ),
    );
  }

  Widget tableWidget(BuildContext context) {
    final data = filteredData.sortBasedOnValue();
    final total = data.values.fold(0, (a, b) => a + b.getTotal());
    return data.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                "Data Tidak Tersedia",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          )
        : CustomTable(
            data: data,
            colorPalette: widget.colorPalette,
            headers: [
              TableText(text: "Provinsi", flexColumnWidth: 100),
              TableText(
                  text: "Keterangan",
                  type: TableTextType.NUMBER,
                  flexColumnWidth: 100)
            ],
            showTriliun: false,
            rowDescriptor: (String key, PkItemCompany item) {
              final jumlah = item.getTotal();
              double percentage = (jumlah / total) * 100;
              return TableRow(children: [
                cell(
                    text: key,
                    onTap: () => widget.actionMapper.openDetailedPage(
                        companyId: widget.companyId, provinsi: key)),
                cell(
                    text: "${percentage.toStringAsFixed(2)}%",
                    textAlign: TextAlign.end),
              ]);
            },
          );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FilterWidget(
        items: tahunList.map((a) => a.toString()).toList(),
        title: "Tahun",
        currentItem: currentTahun.toString(),
        onChanged: (newTahun) {
          setState(() {
            this.currentTahun = int.parse(newTahun);
          });
          processData();
        },
      ),
    );
  }

  Widget titleWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.store.getNamaPendekById(widget.companyId),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ],
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        titleWidget(),
        filterWidget(context),
        mapWidget(context),
        tableWidget(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = "Penyebaran Wilayah PK";
    return BaseScaffold(
      title: title,
      body: (ctx) => SafeArea(
        child: filteredData == null
            ? isError
                ? CustomErrorWidget(
                    onRetry: () => getData(),
                  )
                : LoadingWidget(
                    colorPalette: widget.colorPalette,
                  )
            : mainWidget(context),
      ),
    );
  }
}
