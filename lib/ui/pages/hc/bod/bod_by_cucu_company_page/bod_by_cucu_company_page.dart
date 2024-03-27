import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/common/cucu_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_cucu_company_page/bod_by_cucu_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_cucu_company_page/di/bod_by_cucu_company_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class BODByCucuCompanyPage extends StatefulWidget with InjectableWidget {
  final BODByCucuCompanyPageGraph _graph;

  final CucuPerusahaanDeni company;

  //injected
  ColorPalette colorPalette;
  //injected
  BODByCucuCompanyActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  BODByCucuCompanyPageGraph graph() => _graph;

  BODByCucuCompanyPage(
      {@required this.company, BODByCucuCompanyPageGraph graph})
      : this._graph = graph ?? BODByCucuCompanyPageGraph() {
    setup();
  }

  @override
  _BODByCucuCompanyPageState createState() => _BODByCucuCompanyPageState();
}

class _BODByCucuCompanyPageState extends State<BODByCucuCompanyPage>
    with AfterLayoutMixin<BODByCucuCompanyPage> {
  List<TalentDetail> data;
  List<TalentDetail> filteredData;
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
          .fetchPejabatByCucuCompany(anakName: widget.company.cucu);

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
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
      return pejabat.name.toLowerCase().contains(query.toLowerCase());
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

  Widget listItem(TalentDetail data) {
    return GestureDetector(
      onTap: () => widget.actionMapper.openTalentPage(id: data.id),
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
                        data.name,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.companyName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.kategoriPangkat ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
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

  Widget titleWidget(BuildContext context) {
    return Text(
      "${widget.company.cucu}",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        titleWidget(context),
        searchBar(context),
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
