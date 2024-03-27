import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_company_page/dekom_by_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_company_page/di/dekom_by_company_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class DekomByCompanyPage extends StatefulWidget with InjectableWidget {
  final DekomByCompanyPageGraph _graph;

  final GeneralCompany company;

  //injected
  ColorPalette colorPalette;
  //injected
  DekomByCompanyActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  DekomByCompanyPageGraph graph() => _graph;

  DekomByCompanyPage({@required this.company, DekomByCompanyPageGraph graph})
      : this._graph = graph ?? DekomByCompanyPageGraph() {
    setup();
  }

  @override
  _DekomByCompanyPageState createState() => _DekomByCompanyPageState();
}

class _DekomByCompanyPageState extends State<DekomByCompanyPage>
    with AfterLayoutMixin<DekomByCompanyPage> {
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
          .fetchDekomByCompany(companyId: widget.company.getId());

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
                        data.pangkat,
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
      "${widget.company.getShortName()}",
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
      title: "Dewan Komisaris / Dewan Pengawas",
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
