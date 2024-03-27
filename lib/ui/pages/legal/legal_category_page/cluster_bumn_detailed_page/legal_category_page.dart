import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/legal_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_filter.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/legal/legal_category_page/cluster_bumn_detailed_page/di/legal_category_page_graph.dart';
import 'package:bumn_eid/ui/pages/legal/legal_category_page/cluster_bumn_detailed_page/legal_category_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class LegalCategoryPage extends StatefulWidget with InjectableWidget {
  final LegalCategoryPageGraph _graph;

  final String category;

  //injected
  ColorPalette colorPalette;
  //injected
  LegalController legalController;
  //injected
  LegalCategoryActionMapper actionMapper;
  //injected
  Store<AppState> store;

  LegalCategoryPage({@required this.category, LegalCategoryPageGraph graph})
      : this._graph = graph ?? LegalCategoryPageGraph() {
    setup();
  }

  @override
  LegalCategoryPageGraph graph() => _graph;

  @override
  _LegalCategoryPageState createState() => _LegalCategoryPageState();
}

class _LegalCategoryPageState extends State<LegalCategoryPage>
    with AfterLayoutMixin<LegalCategoryPage> {
  bool isError = false;

  String currentWamen;
  String currentKelas;
  String currentCluster;

  List<LegalItem> items;

  List<LegalItem> jenisPerusahaan;
  List<LegalItem> filteredProfilPerusahaan = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return jenisPerusahaan != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      List<LegalItem> companies;
      companies = await widget.legalController.fetchLegalList();

      setState(() {
        this.items = companies;
        this.jenisPerusahaan = companies
            .where((element) => widget.category == null
                ? true
                : element.tingkat_perkara?.contains(widget.category) ?? false)
            .toList();
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void filterCompany(String query) {
    if (jenisPerusahaan.isEmpty) return;
    final filtered = jenisPerusahaan.where((company) {
      bool penggugat =
          company.penggugat.toLowerCase().contains(query.toLowerCase());
      bool noPerkara =
          company.nomorPerkara.toLowerCase().contains(query.toLowerCase());
      return penggugat || noPerkara;
    }).toList();
    setState(() {
      this.filteredProfilPerusahaan = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SearchBar(
          colorPalette: widget.colorPalette,
          controller: _searchController,
          onChanged: (query) => filterCompany(query),
          labelText: "Cari perkara disini",
          hintText: "Masukkan nama penggugat atau no. perkara."),
    );
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

  Widget companyList(BuildContext context, List<LegalItem> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);
    final sortedCompanies = companies.toList()
      ..sort((a, b) => a.penggugat.compareTo(b.penggugat));

    final filteredCompanies = sortedCompanies.where((element) {
      final a =
          currentWamen == null ? true : element.wamen_bumn == currentWamen;
      final b =
          currentKelas == null ? true : element.kelas_bumn == currentKelas;
      final c = currentCluster == null
          ? true
          : element.cluster_bumn == currentCluster;
      return a && b && c;
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<LegalItem>(
        colorPalette: widget.colorPalette,
        onItemTap: (LegalItem item) => widget.actionMapper.goToDetail(item),
        items: filteredCompanies,
        extraBottomWidget: (LegalItem item) {
          return Text(
            item.nomorPerkara ?? '-',
            style: TextStyle(
              color: Color(0xFFD8B005),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
    );
  }

  Widget clusterTitle(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Text(
          widget.category ?? '-',
          style: TextStyle(
              color: Color(0xFF616B79),
              fontSize: 18.0,
              fontWeight: FontWeight.w700),
        ));
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
        : Container(
            color: widget.colorPalette.defaultBg,
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              BaseFilter(
                onClusterChanged: (a) {
                  setState(() {
                    this.currentCluster = a;
                  });
                },
                onKelasChanged: (a) {
                  setState(() {
                    this.currentKelas = a;
                  });
                },
                onWamenChanged: (a) {
                  setState(() {
                    this.currentWamen = a;
                  });
                },
                caseList: items,
              ),
              widget.category == null ? Container() : clusterTitle(context),
              searchBar(context),
              companyList(
                  context,
                  _searchController.text.isNotEmpty
                      ? filteredProfilPerusahaan
                      : jenisPerusahaan)
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Perkara By Kategori',
      body: (ctx) => mainWidget(context),
    );
  }
}
