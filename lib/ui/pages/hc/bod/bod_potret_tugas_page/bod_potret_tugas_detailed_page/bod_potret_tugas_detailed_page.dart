import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/grafik_potret_kerja_detailed.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_detailed_page/bod_potret_tugas_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_detailed_page/di/bod_potret_tugas_detailed_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

String rangeToTitle(int range) {
  switch (range) {
    case 0:
      return "<1 Tahun";
    case 1:
      return "1-2 Tahun";
    case 2:
      return "2-3 Tahun";
    case 3:
      return "3-4 Tahun";
    case 4:
      return "4-5 Tahun";
    default:
      return "<1 Tahun";
  }
}

// ignore: must_be_immutable
class BODPotretTugasDetailedPage extends StatefulWidget with InjectableWidget {
  final BODPotretTugasDetailedPageGraph _graph;

  final int range;
  final bool now;

  //injected
  ColorPalette colorPalette;
  //injected
  BODPotretTugasDetailedActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  BODPotretTugasDetailedPageGraph graph() => _graph;

  BODPotretTugasDetailedPage(
      {@required this.range,
      @required this.now,
      BODPotretTugasDetailedPageGraph graph})
      : this._graph = graph ?? BODPotretTugasDetailedPageGraph() {
    setup();
  }

  @override
  _BODPotretTugasDetailedPageState createState() =>
      _BODPotretTugasDetailedPageState();
}

class _BODPotretTugasDetailedPageState extends State<BODPotretTugasDetailedPage>
    with AfterLayoutMixin<BODPotretTugasDetailedPage> {
  List<GrafikPotretTugasDetailed> data;
  List<GrafikPotretTugasDetailed> filteredData;
  bool isError = false;

  TextEditingController _searchController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final data = await widget.hcController
          .fetchGrafikPotretTugasDireksiDetailed(
              range: widget.range, now: widget.now);

      setState(() {
        this.data = data.data;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: _searchController,
        onChanged: (query) => filterCompany(query),
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            filled: true,
            labelText: "Cari Pejabat disini",
            hintText: "Masukkan nama Pejabat"),
      ),
    );
  }

  void filterCompany(String query) {
    if (data.isEmpty) return;
    final filtered = data.where((pejabat) {
      return pejabat.nama.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.filteredData = filtered;
    });
  }

  Widget queryNotFoundError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "Mohon maaf, data yang Anda cari tidak tersedia. Silakan coba dengan pencarian lain.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: widget.colorPalette.black),
        ),
      ),
    );
  }

  Widget listItem(GrafikPotretTugasDetailed data) {
    return GestureDetector(
      onTap: () => widget.actionMapper.openTalentPage(
          id: data.id, now: widget.now, fromItms: data.fromItms),
      child: Container(
        height: 100.0,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          elevation: 16.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.nama,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        data.namaPerusahaan,
                        maxLines: 2,
                      ),
                      Text(
                        "Periode ${data.periode}",
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: widget.colorPalette.primary,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data.sisaJabatanDays.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Hari",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${formatNumber(parseDouble(data.persentase))}%",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> listWidget(BuildContext context) {
    final data =
        _searchController.text.isNotEmpty ? this.filteredData : this.data;
    return data.isEmpty
        ? [queryNotFoundError(context)]
        : List.generate(data.length, (idx) {
            return listItem(data[idx]);
          });
  }

  Widget rangeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        rangeToTitle(widget.range),
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    String title;
    if (widget.now) {
      title = "Potret Masa Tugas BOD Saat Ini";
    } else {
      title = "Potret Masa Tugas BOD 8 Tahun Terakhir";
    }
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        searchBar(context),
        titleWidget(context),
        rangeWidget(context),
      ]
        ..addAll(listWidget(context))
        ..add(LastUpdateWidget(
          store: StoreProvider.of<AppState>(context),
          pageName: "hc",
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BOD",
      body: (ctx) => SafeArea(
        child: data == null
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
