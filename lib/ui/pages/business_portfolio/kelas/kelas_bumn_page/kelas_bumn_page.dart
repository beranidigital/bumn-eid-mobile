import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/di/kelas_bumn_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

enum KelasBumnPageType { BUSINESS_PORTFOLIO, HC_EMPLOYEE, HC_DEKOM, HC_BOD }

class KelasBumnPageModel with SingleListItem {
  final String kelas;
  final int total;

  KelasBumnPageModel({@required this.kelas, @required this.total});

  @override
  String getTitle() {
    return kelas;
  }
}

// ignore: must_be_immutable
class KelasBumnPage extends StatefulWidget with InjectableWidget {
  final KelasBumnPageGraph _graph;

  final KelasBumnPageType type;

  //injected
  ColorPalette colorPalette;
  //injected
  KelasBumnActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  CompaniesController companiesController;
  //injected
  Store<AppState> store;

  @override
  KelasBumnPageGraph graph() => _graph;

  KelasBumnPage(
      {this.type = KelasBumnPageType.BUSINESS_PORTFOLIO,
      KelasBumnPageGraph graph})
      : this._graph = graph ?? KelasBumnPageGraph() {
    setup();
  }

  @override
  _KelasBumnPageState createState() => _KelasBumnPageState();
}

class _KelasBumnPageState extends State<KelasBumnPage>
    with AfterLayoutMixin<KelasBumnPage> {
  Map<String, List<GeneralCompany>> tableData;
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
      Map<String, List<GeneralCompany>> categorizedCompanies = {};
      List<GeneralCompany> companiesList;
      if (widget.type == KelasBumnPageType.BUSINESS_PORTFOLIO) {
        companiesList = widget.store.state.companiesState.companies;
      } else {
        companiesList = await widget.hcController.fetchHcCompanies();
      }
      if (companiesList.isEmpty) throw Exception();

      companiesList.forEach((company) {
        final kelas = convertKelasToString(parseInt(company.getKelas()));
        if (!categorizedCompanies.containsKey(kelas)) {
          categorizedCompanies[kelas] = [company];
        } else {
          categorizedCompanies[kelas] = categorizedCompanies[kelas]
            ..add(company);
        }
      });

      setState(() {
        this.tableData = categorizedCompanies;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget chartWidget(BuildContext context) {
    return CustomPieChart(
      tableData: tableData,
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 5,
    );
  }

  TextEditingController _searchController = TextEditingController();
  String query = '';

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SearchBar(
        colorPalette: widget.colorPalette,
        controller: _searchController,
        onChanged: (query) {
          setState(() {
            this.query = query;
          });
        },
        labelText: "Cari perusahaan disini",
        hintText: "Masukkan nama perusahaan.",
      ),
    );
  }

  Widget companyList(BuildContext context) {
    final sortedData =
        sortBasedOnKey(tableData.map((k, v) => MapEntry(k.split(" ")[1], v)));
    final List<KelasBumnPageModel> convertedData = [];
    sortedData.keys.forEach((kelas) {
      convertedData.add(KelasBumnPageModel(
          kelas: "Kelas $kelas", total: sortedData[kelas].length));
    });

    List<GeneralCompany> data = tableData['Kelas $currentKelas'];
    if (query != null && query.isNotEmpty) {
      data = data
          .where((e) =>
              e.getName().contains(query) || e.getShortName().contains(query))
          .toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<GeneralCompany>(
        colorPalette: widget.colorPalette,
        onItemTap: (GeneralCompany item) {
          ApiStatistic().insertStatistic("Business Portofolio",
              "Detail Profil BUMN ${item.getName()} Kelas");
          widget.actionMapper.openDetailedJenisPage(item.getId());
        },
        items: data,
      ),
    );
  }

  String currentKelas = '1';

  Widget filterItem(
      BuildContext context, List<GeneralCompany> data, String key) {
    return InkWell(
      onTap: () {
        setState(() {
          currentKelas = key;
        });

        getData();
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentKelas == key ? Color(0xFF1FA4CA) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.0,
              blurRadius: 4,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: 13.0,
          horizontal: 13.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'res/images/ic_wamen_2.png',
                  height: 18.0,
                  color: currentKelas == key ? Colors.white : Color(0xFF1FA4CA),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Kelas $key',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color:
                        currentKelas == key ? Colors.white : Color(0xFF1FA4CA),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
            Text(
              data.where((a) => a.getKelas() == key).length.toString(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
                color: currentKelas == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
            Text(
              'BUMN',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
                color: currentKelas == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    List<GeneralCompany> data = tableData.values
        .toList()
        .fold([], (a, b) => a == null ? b : [...a, ...b]);
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          filterItem(
            context,
            data,
            '1',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            '2',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            '3',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            '4',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            '5',
          ),
          SizedBox(
            width: 16.0,
          ),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          filterWidget(context),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: searchBar(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: companyList(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Kelas',
      body: (ctx) => tableData == null
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(colorPalette: widget.colorPalette)
          : mainWidget(context),
    );
  }
}
