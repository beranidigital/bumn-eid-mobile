import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class GenderPageData with Sortable {

  final int tahun;
  final int jumlah;

  GenderPageData({
     @required
     this.tahun,
     @required
     this.jumlah
  });

  @override
  num getNumber() {
    return jumlah;
  }

}

class GenderPage extends StatefulWidget {

  final String companyId;
  final ColorPalette colorPalette;
  final HcController hcController;

  GenderPage({
     @required
     this.companyId,
     @required
     this.colorPalette,
     @required
     this.hcController
  });

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> with AfterLayoutMixin<GenderPage> {

  String currentTahun;
  List<String> tahunList;

  Map<String, List<GenderPageData>> data;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null && tahunList != null && currentTahun != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      Map<String, List<GenderPageData>> tableData = {
        "Laki-Laki": [],
        "Perempuan": [],
      };
      List<String> tahunList = [];
      final fetchedEmployeeList = await widget.hcController.fetchEmployeeGender(companyId: widget.companyId);
      fetchedEmployeeList..sort((a,b) => a.tahun.compareTo(b.tahun));
      fetchedEmployeeList.forEach((datum) {
        tableData["Laki-Laki"].add(
            GenderPageData(jumlah: datum.laki, tahun: datum.tahun)
        );
        tableData["Perempuan"].add(
            GenderPageData(jumlah: datum.perempuan, tahun: datum.tahun)
        );
        if (!tahunList.contains(datum.tahun.toString())) tahunList.add(datum.tahun.toString());
      });

      setState(() {
        this.data = tableData;
        this.tahunList = tahunList;
        this.currentTahun = tahunList.last;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget dataWidget() {
    final sortedData = data.map((k,v) => MapEntry(k, v.firstWhere((datum)=>datum.tahun.toString() == currentTahun)));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        filterWidget(),
        chartWidget(sortedData),
        tableWidget(sortedData)
      ],
    );
  }

  Widget tableWidget(Map<String, GenderPageData> datas) {

    return CustomTable(
      colorPalette: widget.colorPalette,
      data: datas.sortBasedOnValue(),
      headers: [
        TableText(text: "Jenjang"),
        TableText(text: "Jumlah", type: TableTextType.NUMBER),
      ],
      showTriliun: false,
      rowDescriptor: (key, GenderPageData data) {
        return TableRow(
            children: [
              cell(text: key),
              cell(text: formatNumber(data.jumlah), textAlign: TextAlign.end),
            ]
        );
      },
    );
  }

  Widget chartWidget(Map<String, GenderPageData> datas) {
    return CustomPieChart(
      tableData: datas.map((k,v) => MapEntry(k, [v])),
      colorPalette: widget.colorPalette,
      customCountFunction: (allData) => allData.first.jumlah,
      customTotalCount: datas.values.fold(0, (a,b) => a+b.jumlah),
      maxItemToShowLabel: 4,
    );
  }

  Widget filterWidget() {
    return FilterWidget(
      items: tahunList,
      currentItem: currentTahun,
      onChanged: (newTahun) {
        setState(() {
          this.currentTahun = newTahun;
        });
      },
      title: "Tahun Periode",
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isDataReady()
        ? isError ? CustomErrorWidget(onRetry: () => getData(),) : LoadingWidget(colorPalette: widget.colorPalette,)
        : dataWidget();
  }
}
