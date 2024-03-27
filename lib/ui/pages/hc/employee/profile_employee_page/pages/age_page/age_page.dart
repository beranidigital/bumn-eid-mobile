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

class AgePageData with Sortable {

  final int tahun;
  final int jumlah;

  AgePageData({
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

class AgePage extends StatefulWidget {

  final String companyId;
  final ColorPalette colorPalette;
  final HcController hcController;

  AgePage({
     @required
     this.companyId,
     @required
     this.colorPalette,
     @required
     this.hcController
  });

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> with AfterLayoutMixin<AgePage> {

  String currentTahun;
  List<String> tahunList;

  Map<String, List<AgePageData>> data;
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
      Map<String, List<AgePageData>> tableData = {
        "Diatas 56 Tahun": [],
        "Antara 46-55 Tahun": [],
        "Antara 36-45 Tahun": [],
        "Antara 26-35 Tahun": [],
        "Dibawah 25 Tahun": [],
      };
      List<String> tahunList = [];
      final fetchedEmployeeList = await widget.hcController.fetchEmployeeAge(companyId: widget.companyId);
      fetchedEmployeeList..sort((a,b) => a.tahun.compareTo(b.tahun));
      fetchedEmployeeList.forEach((datum) {
        tableData["Diatas 56 Tahun"].add(
            AgePageData(jumlah: datum.diatas56, tahun: datum.tahun)
        );
        tableData["Antara 46-55 Tahun"].add(
            AgePageData(jumlah: datum.antara4556, tahun: datum.tahun)
        );
        tableData["Antara 36-45 Tahun"].add(
            AgePageData(jumlah: datum.antara3645, tahun: datum.tahun)
        );
        tableData["Antara 26-35 Tahun"].add(
            AgePageData(jumlah: datum.antara2635, tahun: datum.tahun)
        );
        tableData["Dibawah 25 Tahun"].add(
            AgePageData(jumlah: datum.dibawah25, tahun: datum.tahun)
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

  Widget tableWidget(Map<String, AgePageData> datas) {

    return CustomTable(
      colorPalette: widget.colorPalette,
      data: datas.sortBasedOnValue(),
      headers: [
        TableText(text: "Jenjang"),
        TableText(text: "Jumlah", type: TableTextType.NUMBER),
      ],
      showTriliun: false,
      rowDescriptor: (key, AgePageData data) {
        return TableRow(
            children: [
              cell(text: key),
              cell(text: formatNumber(data.jumlah), textAlign: TextAlign.end),
            ]
        );
      },
    );
  }

  Widget chartWidget(Map<String, AgePageData> datas) {
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
