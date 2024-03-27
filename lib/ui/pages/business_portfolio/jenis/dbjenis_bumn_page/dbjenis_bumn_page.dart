import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_jenis_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/jenis_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/dbjenis_bumn_page/dbjenis_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/dbjenis_bumn_page/di/dbjenis_bumn_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/core/redux/actions/companies/companies_actions.dart';

class JenisBumnPageModel with SingleListItem {
  final String jenis;
  final int total;

  JenisBumnPageModel({@required this.jenis, @required this.total});

  @override
  String getTitle() {
    return jenis;
  }
}

// ignore: must_be_immutable
class DBJenisBumnPage extends StatefulWidget with InjectableWidget {
  final DBJenisBumnPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  DBJenisBumnActionMapper actionMapper;
  //injected
  JenisController jenisController;

  @override
  DBJenisBumnPageGraph graph() => _graph;

  DBJenisBumnPage([graph]) : this._graph = graph ?? DBJenisBumnPageGraph() {
    setup();
  }

  @override
  _DBJenisBumnPageState createState() => _DBJenisBumnPageState();
}

class _DBJenisBumnPageState extends State<DBJenisBumnPage>
    with AfterLayoutMixin<DBJenisBumnPage> {
  List<JenisPerusahaan> companies;
  Map<String, List<GrafikJenisPerusahaan>> tableData;
  bool isError = false;

  TextEditingController _searchController = TextEditingController();

  List<JenisPerusahaan> companiesChange = [];

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getCompanyData({
    String jenis = 'Persero',
  }) async {
    try {
      setState(() {
        this.companies = null;
      });
      final cpns = await widget.jenisController.fetchJenis(
        jenisBumn: jenis,
      );
      setState(() {
        this.companies = cpns;
      });
    } catch (ex) {
      print(ex);
    }
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final data = await widget.jenisController.fetchGrafikJenis();
      Map<String, List<GrafikJenisPerusahaan>> chartData = {};
      data.forEach((grafikData) {
        if (chartData.containsKey(grafikData.jenis_bumn)) {
          chartData[grafikData.jenis_bumn].add(grafikData);
        } else {
          chartData[grafikData.jenis_bumn] = [grafikData];
        }
      });

      processData(chartData);

      getCompanyData();
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  String currentOwnership = 'Persero';

  Widget filterItem(
    BuildContext context,
    List<GrafikJenisPerusahaan> data,
    String key,
    int total,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          currentOwnership = key;
        });

        getCompanyData(jenis: key);
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentOwnership == key ? Color(0xFF1FA4CA) : Colors.white,
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
          vertical: 11.0,
          horizontal: 11.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'res/images/ic_wamen_2.png',
                  height: 17.0,
                  color: currentOwnership == key
                      ? Colors.white
                      : Color(0xFF1FA4CA),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  key,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: currentOwnership == key
                        ? Colors.white
                        : Color(0xFF1FA4CA),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [

                //   ],
                // ),
              ],
            ),
            Text(
              total.toString(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
                color:
                    currentOwnership == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
            Text(
              'BUMN',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
                color:
                    currentOwnership == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    Map<String, int> ownerships = {};
    List<GrafikJenisPerusahaan> dataChange = List();
    List<GrafikJenisPerusahaan> data = tableData.values
        .toList()
        .fold([], (a, b) => a == null ? b : [...a, ...b]);
    data.forEach((element) {
      if (!ownerships.containsKey(element.jenis_bumn) &&
          element.tahun == '2020') {
        // print(element.jenis_bumn);
        ownerships[element.jenis_bumn] = element.jumlah;
      }
    });
    for (int i = 0; i < data.length; i++) {
      if (data[i].tahun == "2020") {
        dataChange.add(new GrafikJenisPerusahaan(
          jenis_bumn: data[i].jenis_bumn,
          jumlah: data[i].jumlah,
          tahun: data[i].tahun,
        ));
      }
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.125,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            filterItem(
              context,
              dataChange,
              dataChange[0].jenis_bumn,
              dataChange[0].jumlah,
            ),
            SizedBox(
              width: 16.0,
            ),
            filterItem(
              context,
              dataChange,
              dataChange[2].jenis_bumn,
              dataChange[2].jumlah,
            ),
            SizedBox(
              width: 16.0,
            ),
            filterItem(
              context,
              dataChange,
              dataChange[1].jenis_bumn,
              dataChange[1].jumlah,
            ),
            SizedBox(
              width: 16.0,
            ),
            filterItem(
              context,
              dataChange,
              dataChange[3].jenis_bumn,
              dataChange[3].jumlah,
            ),
            SizedBox(
              width: 16.0,
            )
          ],
        ),
      ),
      // ListView(
      //   scrollDirection: Axis.horizontal,
      //   children: ownerships.keys.map((e) {
      //     return Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         filterItem(
      //         context,
      //         data,
      //         e,
      //         ownerships[e],
      //         ),
      //         SizedBox(
      //           width: 16.0,
      //         )
      //       ],
      //     );
      //   }).toList(),
      // ),
    );
  }

  processData(Map<String, List<GrafikJenisPerusahaan>> chartData) {
    chartData.values.forEach((list) {
      list.sort((GrafikJenisPerusahaan a, GrafikJenisPerusahaan b) =>
          int.parse(a.tahun).compareTo(int.parse(b.tahun)));
    });

    setState(() {
      this.tableData = chartData;
    });
  }

  Widget companyList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "* Berdasarkan data 2020",
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          searchBar(context),
          SizedBox(
            height: 8.0,
          ),
          // Text(companies.length.toString()),
          SingleListView<JenisPerusahaan>(
            colorPalette: widget.colorPalette,
            onItemTap: (JenisPerusahaan item) {
              ApiStatistic().insertStatistic("Business Portofolio",
                  "Detail Profil BUMN ${item.nama} Ownership");
              widget.actionMapper.openCompanyDetailPage(item);
            },
            items: (companiesChange.isEmpty) ? companies : companiesChange,
          ),
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return SearchBar(
      colorPalette: ColorPalette(),
      controller: _searchController,
      onChanged: (query) {
        companiesChange = [];
        if (query.isEmpty) {
          companiesChange = companies;
        } else {
          for (int i = 0; i < companies.length; i++) {
            if (companies[i].nama.toLowerCase().toString().contains(query)) {
              companiesChange.add(companies[i]);
            }
          }
        }
        setState(() {});
      },
      // widget.store.dispatch(FilterTotalCompaniesAction(query: query)),
      labelText: "Cari perusahaan disini",
      hintText: "Masukkan nama perusahaan. e.g. Mandiri",
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        children: <Widget>[
          filterWidget(context),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: companyList(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Ownership',
      body: (ctx) => tableData == null || companies == null
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : mainWidget(context),
    );
  }
}
