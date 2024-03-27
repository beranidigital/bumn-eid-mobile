import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_detailed_page/di/penyebaran_wilayah_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class PenyebaranWilayahDetailedPage extends StatefulWidget
    with InjectableWidget {
  final PenyebaranWilayahDetailedPageGraph _graph;

  final PenyebaranWilayahType type;
  final int tahun;
  final String provinsi;

  //injected
  ColorPalette colorPalette;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  PenyebaranWilayahDetailedPageGraph graph() => _graph;

  PenyebaranWilayahDetailedPage(
      {@required this.type,
      @required this.tahun,
      @required this.provinsi,
      PenyebaranWilayahDetailedPageGraph graph})
      : this._graph = graph ?? PenyebaranWilayahDetailedPageGraph() {
    setup();
  }

  @override
  _PenyebaranWilayahDetailedPageState createState() =>
      _PenyebaranWilayahDetailedPageState();
}

class _PenyebaranWilayahDetailedPageState
    extends State<PenyebaranWilayahDetailedPage>
    with AfterLayoutMixin<PenyebaranWilayahDetailedPage> {
  List<PenyebaranWilayahDataType> data;
  Map<String, List<PenyebaranWilayahDataType>> filteredData;
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
      List<PenyebaranWilayahDataType> companiesList;
      if (widget.type == PenyebaranWilayahType.PROGRAM_KEMITRAAN) {
        companiesList = await widget.csrController.fetchPenyebaranWilayahPkList(
            provinsi: widget.provinsi, tahun: widget.tahun.toString());
      } else {
        companiesList = await widget.csrController.fetchPenyebaranWilayahBlList(
            provinsi: widget.provinsi, tahun: widget.tahun.toString());
      }
      if (companiesList.isEmpty) throw Exception();

      setState(() {
        this.data = companiesList;
      });

      processData();
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  void processData() {
    Map<String, List<PenyebaranWilayahDataType>> categorizedCompanies = {};
    data.forEach((company) {
      if (!categorizedCompanies.containsKey(company.getJenis())) {
        categorizedCompanies[company.getJenis()] = [company];
      } else {
        categorizedCompanies[company.getJenis()]..add(company);
      }
    });

    setState(() {
      this.filteredData = categorizedCompanies;
    });
  }

  Widget chartWidget(BuildContext context) {
    return CustomPieChart<PenyebaranWilayahDataType>(
      tableData: filteredData,
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 3,
      customTotalCount: filteredData.values.fold(
          0, (a, b) => a + b.fold(0, (c, d) => c + d.getTotal().truncate())),
      customCountFunction: (List items) =>
          items.fold(0, (a, b) => a + b.getTotal().truncate()),
    );
  }

  Widget tableWidget(BuildContext context) {
    final Map<String, int> tableMap = {
      "Realisasi Dana": data.fold(0, (a, b) => a + b.getTotal().truncate()),
    };
    if (widget.type == PenyebaranWilayahType.PROGRAM_KEMITRAAN) {
      tableMap["Jumlah Mitra"] = data.length;
    }
    return CustomTable(
      data: tableMap,
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Jenis Data", flexColumnWidth: 100),
        TableText(
            text: "Nilai", type: TableTextType.NUMBER, flexColumnWidth: 100)
      ],
      showTriliun: false,
      rowDescriptor: (String key, int item) {
        final number = item > 1000000
            ? "${formatNumber(item / Constants.billion)} Miliar"
            : formatNumber(item);
        return TableRow(children: [
          cell(
            text: key,
          ),
          cell(text: number, textAlign: TextAlign.end),
        ]);
      },
    );
  }

  Widget titleText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Text(
        "Detail ${widget.provinsi} tahun ${widget.tahun}",
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: <Widget>[
        titleText(context),
        chartWidget(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: tableWidget(context),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.type == PenyebaranWilayahType.PROGRAM_KEMITRAAN) {
      title = "Penyebaran Wilayah PK";
    } else {
      title = "Penyebaran Wilayah BL";
    }
    return BaseScaffold(
      title: title,
      body: (ctx) => filteredData == null
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(colorPalette: widget.colorPalette)
          : mainWidget(context),
    );
  }
}
