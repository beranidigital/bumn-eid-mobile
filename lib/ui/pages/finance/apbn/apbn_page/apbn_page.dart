import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_apbn.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/apbn_page/apbn_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/apbn_page/di/apbn_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class APBNPageModel with SingleListItem {
  final String jenisAkun;
  final int total;

  APBNPageModel({@required this.jenisAkun, @required this.total});

  @override
  String getTitle() {
    return jenisAkun;
  }
}

// ignore: must_be_immutable
class APBNPage extends StatefulWidget with InjectableWidget {
  final APBNPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  APBNActionMapper actionMapper;
  //injected
  FinanceController financeController;

  @override
  APBNPageGraph graph() => _graph;

  APBNPage([graph]) : this._graph = graph ?? APBNPageGraph() {
    setup();
  }

  @override
  _APBNPageState createState() => _APBNPageState();
}

class _APBNPageState extends State<APBNPage> with AfterLayoutMixin<APBNPage> {
  final tahunList = Constants.tahunList.map((e) => e.toString()).toList();
  String currentTahun = Constants.latestDataYear;

  Map<String, List<GrafikAPBN>> tableData;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataAvailable() {
    return tableData != null;
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final dividen = await widget.financeController.fetchGrafikDividen();
      final pajak = await widget.financeController.fetchGrafikPajak();
      final pnbp = await widget.financeController.fetchGrafikPnbp();

      Map<String, List<GrafikAPBN>> chartData = {};
      dividen.forEach((grafikData) {
        chartData[grafikData.tahun] = [grafikData];
      });

      pajak.forEach((grafikData) {
        chartData[grafikData.tahun].add(grafikData);
      });
      pnbp.forEach((grafikData) {
        chartData[grafikData.tahun].add(grafikData);
      });

      processData(chartData);
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  processData(Map<String, List<GrafikAPBN>> chartData) {
    setState(() {
      this.tableData = chartData;
    });
  }

  Widget chartWidget(BuildContext context) {
    return CustomListBarChart(
      colorPalette: widget.colorPalette,
      data: tableData,
      leftPadding: 24,
      keyToColor: {
        "pajak": Color(0xFFFE8282),
        "pnbp": Color(0xFFFBD300),
        "dividen": Color(0xFF4572E5),
      },
    );
  }

  Widget companyList(BuildContext context) {
    final List<APBNPageModel> convertedData = [];
    tableData[currentTahun].forEach((value) {
      convertedData.add(APBNPageModel(
          jenisAkun: value.jenis_akun,
          total: parseDouble(value.jumlah).toInt()));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<APBNPageModel>(
        colorPalette: widget.colorPalette,
        onItemTap: (APBNPageModel item) {
          ApiStatistic().insertStatistic(
              "Finance", "List Ket ${item.jenisAkun} Kontribusi Pada Negara");
          widget.actionMapper.openDetailedPage(jenisAkun: item.jenisAkun);
        },
        items: convertedData,
        leadingWidget: (APBNPageModel item) =>
            SumTypeText(colorPalette: widget.colorPalette, sum: item.total),
      ),
    );
  }

  Widget tableWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: FilterWidget(
              items: tahunList,
              title: "Filter Tahun",
              currentItem: currentTahun,
              onChanged: (newTahun) {
                setState(() {
                  this.currentTahun = newTahun;
                });
              },
            ),
          ),
          Text(
            "* Jumlah dalam triliun rupiah",
            style: TextStyle(fontSize: 16.0),
          ),
          companyList(context),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[chartWidget(context), tableWidget(context)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("APBNPage.Title"),
      body: (ctx) => SafeArea(
        child: !isDataAvailable()
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
