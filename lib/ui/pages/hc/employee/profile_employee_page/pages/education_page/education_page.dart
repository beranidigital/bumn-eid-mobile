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

class EducationPageData with Sortable {

  final int tahun;
  final int jumlah;

  EducationPageData({
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

class EducationPage extends StatefulWidget {

  final String companyId;
  final ColorPalette colorPalette;
  final HcController hcController;

  EducationPage({
     @required
     this.companyId,
     @required
     this.colorPalette,
     @required
     this.hcController
  });

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> with AfterLayoutMixin<EducationPage> {

  String currentTahun;
  List<String> tahunList;

  Map<String, List<EducationPageData>> data;
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
      Map<String, List<EducationPageData>> tableData = {
        "S3": [],
        "S2": [],
        "S1": [],
        "D3": [],
        "D2": [],
        "D1": [],
        "SMA": [],
        "SMP": [],
        "SD": [],
      };
      List<String> tahunList = [];
      final fetchedEmployeeList = await widget.hcController.fetchEmployeeEducation(companyId: widget.companyId);
      fetchedEmployeeList..sort((a,b) => a.tahun.compareTo(b.tahun));
      fetchedEmployeeList.forEach((datum) {
        tableData["S3"].add(
            EducationPageData(jumlah: datum.s3, tahun: datum.tahun)
        );
        tableData["S2"].add(
            EducationPageData(jumlah: datum.s2, tahun: datum.tahun)
        );
        tableData["S1"].add(
            EducationPageData(jumlah: datum.s1, tahun: datum.tahun)
        );
        tableData["D3"].add(
            EducationPageData(jumlah: datum.d3, tahun: datum.tahun)
        );
        tableData["D2"].add(
            EducationPageData(jumlah: datum.d2, tahun: datum.tahun)
        );
        tableData["D1"].add(
            EducationPageData(jumlah: datum.d1, tahun: datum.tahun)
        );
        tableData["SMA"].add(
            EducationPageData(jumlah: datum.sma, tahun: datum.tahun)
        );
        tableData["SMP"].add(
            EducationPageData(jumlah: datum.smp, tahun: datum.tahun)
        );
        tableData["SD"].add(
            EducationPageData(jumlah: datum.sd, tahun: datum.tahun)
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

  Widget tableWidget(Map<String, EducationPageData> datas) {

    return CustomTable(
      colorPalette: widget.colorPalette,
      data: datas.sortBasedOnValue(),
      headers: [
        TableText(text: "Jenjang"),
        TableText(text: "Jumlah", type: TableTextType.NUMBER),
      ],
      showTriliun: false,
      rowDescriptor: (key, EducationPageData data) {
        return TableRow(
            children: [
              cell(text: key),
              cell(text: formatNumber(data.jumlah), textAlign: TextAlign.end),
            ]
        );
      },
    );
  }

  Widget chartWidget(Map<String, EducationPageData> datas) {
    return CustomPieChart(
      tableData: datas.map((k,v) => MapEntry(k, [v])),
      colorPalette: widget.colorPalette,
      customCountFunction: (allData) => allData.first.jumlah,
      customTotalCount: datas.values.fold(0, (a,b) => a+b.jumlah),
      maxItemToShowLabel: 3,
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
