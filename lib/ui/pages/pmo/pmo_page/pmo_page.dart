import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/pmo_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/pmo/project_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/pmo/pmo_page/di/pmo_page_graph.dart';
import 'package:bumn_eid/ui/pages/pmo/pmo_page/pmo_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class PMOPageModel with SingleListItem {
  final int id;
  final String name;
  final String month;

  PMOPageModel({@required this.id, @required this.name, @required this.month});

  @override
  String getTitle() {
    return name;
  }
}

// ignore: must_be_immutable
class PMOPage extends StatefulWidget with InjectableWidget {
  final PMOPageGraph _graph;

  PMOPage([graph]) : this._graph = graph ?? PMOPageGraph() {
    setup();
  }

  //injected
  ColorPalette colorPalette;
  //injected
  PMOPageActionMapper actionMapper;
  //injected
  PMOController pmoController;
  //injected
  Store<AppState> store;

  @override
  PMOPageGraph graph() => _graph;

  @override
  _PMOPageState createState() => _PMOPageState();
}

class _PMOPageState extends State<PMOPage> with AfterLayoutMixin<PMOPage> {
  List<String> bulanList;
  String currentBulan;

  List<ProjectItem> data;
  List<ProjectItem> filteredData;
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

  bool isDataReady() {
    return data != null && bulanList != null && currentBulan != null;
  }

  void getData() async {
    try {
      final data = await widget.pmoController.fetchAllProjects();

      final bulanList = data.map((a) => a.bulanString).toSet().toList()
        ..add("-");
      final currentBulan = "-";

      setState(() {
        this.data = data;
        this.bulanList = bulanList;
        this.currentBulan = currentBulan;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget searchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SearchBar(
            colorPalette: widget.colorPalette,
            controller: _searchController,
            onChanged: (query) => filterCompany(query),
            labelText: "Cari Project disini",
            hintText: "Masukkan nama Project",
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        bulanFilter(),
      ],
    );
  }

  void filterByBulan(String bulan) {
    if (data.isEmpty) return;
    if (bulan == "-") {
      setState(() {
        this.filteredData = data;
      });
      return;
    }
    final filtered = data.where((project) {
      return project.bulanString == bulan;
    }).toList();
    setState(() {
      this.filteredData = filtered;
    });
  }

  void filterCompany(String query) {
    if (data.isEmpty) return;
    final filtered = data.where((project) {
      return project.nama.toLowerCase().contains(query.toLowerCase());
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

  Widget programsWidget() {
    final data = _searchController.text.isNotEmpty || currentBulan != "-"
        ? this.filteredData
        : this.data;
    data.sort((a, b) => a.bulan.compareTo(b.bulan));
    if (data.isEmpty) queryNotFoundError(context);

    final List<PMOPageModel> convertedData = [];
    data.forEach((value) {
      convertedData.add(PMOPageModel(
          id: value.id, name: value.nama, month: value.bulanString));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<PMOPageModel>(
        colorPalette: widget.colorPalette,
        onItemTap: (item) {
          ApiStatistic()
              .insertStatistic("PMO", "Level 2 Detail PMO Company ${item.id}");
          widget.actionMapper.openProjectDetail(id: item.id);
        },
        items: convertedData,
        leadingWidget: (PMOPageModel item) => SumTypeText(
          colorPalette: widget.colorPalette,
          sum: null,
          sumNotNumber: item.month,
          sumText: "Bulan",
        ),
      ),
    );
  }

  Widget programsTitle() {
    return Text(
      "Program Prioritas",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  Widget bulanFilter() {
    return FilterWidget(
      currentItem: currentBulan,
      title: "Filter Bulan",
      withTitle: false,
      width: 100.0,
      items: bulanList,
      onChanged: (newBulan) {
        setState(() {
          this.currentBulan = newBulan;
        });
        filterByBulan(newBulan);
      },
    );
  }

  Widget mainWidget(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                searchBar(context),
                programsWidget(),
                LastUpdateWidget(
                  pageName: "pmo",
                  store: widget.store,
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'PMO',
      withTopBlue: true,
      body: (ctx) => mainWidget(ctx),
    );
  }
}
