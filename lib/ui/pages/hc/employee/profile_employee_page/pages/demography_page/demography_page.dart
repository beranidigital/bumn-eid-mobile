import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/ui/components/custom_bar_chart.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

enum DemographyPageDataType {
  PKWT,
  PKWTT,
}

class DemographyPageData with BarChartDataType {

  final DemographyPageDataType type;
  final int tahun;
  final int jumlah;

  DemographyPageData({
    @required
    this.type,
    @required
    this.tahun,
    @required
    this.jumlah
  });

  @override
  Color getColor() {
    return Color(0xff3459B9);
  }

  @override
  int getX() {
    return tahun;
  }

  @override
  double getY() {
    return jumlah.toDouble();
  }

}

class DemographyPage extends StatefulWidget {

  final String companyId;
  final ColorPalette colorPalette;
  final HcController hcController;

  DemographyPage({
     @required
     this.companyId,
     @required
     this.colorPalette,
     @required
     this.hcController
  });

  @override
  _DemographyPageState createState() => _DemographyPageState();
}

class _DemographyPageState extends State<DemographyPage> with AfterLayoutMixin<DemographyPage> {

  Map<String, List<DemographyPageData>> data;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      Map<String, List<DemographyPageData>> tableData = {
        "PKWT": [],
        "PKWTT": [],
      };
      final fetchedEmployeeList = await widget.hcController.fetchEmployeeDemografi(companyId: widget.companyId);
      fetchedEmployeeList..sort((a,b) => b.tahun.compareTo(a.tahun));
      fetchedEmployeeList.forEach((datum) {
        tableData["PKWT"].add(
            DemographyPageData(type: DemographyPageDataType.PKWT, tahun: datum.tahun, jumlah: datum.pkwt)
        );
        tableData["PKWTT"].add(
            DemographyPageData(type: DemographyPageDataType.PKWT, tahun: datum.tahun, jumlah: datum.pkwtt)
        );
      });

      setState(() {
        this.data = tableData;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  List<Widget> dataWidget() {
    return List.generate(data.keys.length, (idx) {
      String key = data.keys.toList()[idx];
      return itemWidget(key, data[key]);
    });
  }

  Widget itemWidget(String key, List<DemographyPageData> datas) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          key,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w700
          ),
        ),
        chartWidget(datas),
        tableWidget(datas)
      ],
    );
  }

  Widget tableWidget(List<DemographyPageData> datas) {
    return CustomTable(
      colorPalette: widget.colorPalette,
      data: datas.asMap().map((k,v) => MapEntry(v.tahun.toString(), v)),
      headers: [
        TableText(text: "Tahun"),
        TableText(text: "Jumlah", type: TableTextType.NUMBER),
      ],
      showTriliun: false,
      rowDescriptor: (key, DemographyPageData data) {
        return TableRow(
            children: [
              cell(text: key),
              cell(text: formatNumber(data.jumlah), textAlign: TextAlign.end),
            ]
        );
      },
    );
  }

  Widget chartWidget(List<DemographyPageData> datas) {
    return CustomBarChart(
      items: datas,
      colorPalette: widget.colorPalette,
      bottomRotateAngle: 300,
      itemWidth: 10,
      leftMargin: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isDataReady()
        ? isError ? CustomErrorWidget(onRetry: () => getData(),) : LoadingWidget(colorPalette: widget.colorPalette,)
        : Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dataWidget(),
    );
  }
}
