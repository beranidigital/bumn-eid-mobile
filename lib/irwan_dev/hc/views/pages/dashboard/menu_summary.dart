import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:bumn_eid/irwan_dev/hc/controllers/dashboard/summary_dashboard_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hc_main_page.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/chart_title.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/dual_horizontal_bar.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_stacked_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/partial_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/pie_chart_legenda.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_pie_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/vertical_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/genders.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/text_underline_button.dart';

class MenuSummaryDashboard extends StatelessWidget {
  KetSummaryDashboard dataSummary;
  MenuSummaryDashboard({
    Key key,
    this.dataSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var laki2 = 0;
    var perempuan = 0;

    if (dataSummary.gender_perusahaan_induk.length == 0 ||
        dataSummary.gender_perusahaan_induk.isEmpty ||
        dataSummary.gender_perusahaan_induk == null) {
    } else if (dataSummary.gender_perusahaan_induk.length < 2) {
      if (dataSummary.gender_perusahaan_induk[0].jenis_kelamin == "P") {
        perempuan = dataSummary.gender_perusahaan_induk[0].total ?? 0;
      } else {
        laki2 = dataSummary.gender_perusahaan_induk[0].total ?? 0;
      }
    } else {
      for (int i = 0; i < dataSummary.gender_perusahaan_induk.length; i++) {
        if (dataSummary.gender_perusahaan_induk[i].jenis_kelamin == "P")
          perempuan = dataSummary.gender_perusahaan_induk[i].total;
        else if (dataSummary.gender_perusahaan_induk[i].jenis_kelamin == "L")
          laki2 = dataSummary.gender_perusahaan_induk[i].total;
      }
    }

    var persentaseLaki = ((laki2 + perempuan) == 0)
        ? 0
        : (laki2 * 100 / (laki2 + perempuan)).toInt();
    var persentasePerempuan = ((laki2 + perempuan) == 0)
        ? 0
        : (perempuan * 100 / (laki2 + perempuan)).toInt();

    return Container(
      child: Column(
        children: [
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: FilteringList(
          //     icon: [
          //       Icons.ac_unit,
          //       Icons.pedal_bike,
          //       Icons.access_alarm,
          //       Icons.ac_unit,
          //       Icons.pedal_bike,
          //       Icons.access_alarm
          //     ],
          //     title: [
          //       "Filter",
          //       "Filter",
          //       "Filter",
          //       "Filter",
          //       "Filter",
          //       "Filter"
          //     ],
          //   ),
          // ),
          DualHorizontalBar(
              persebaranUsiaGender: dataSummary.persebaran_usia_gender),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.45),
                  offset: Offset(0, 3),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: textBorder("Total Perusahaan",
                          "${dataSummary.summary.total_perusahaan}"),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: textBorder("Total Anggaran",
                          "${dataSummary.summary.total_anggaran}"),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: color_blue, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Karyawan",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${dataSummary.summary.total_karyawan}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child: textBorder(
                            "Total BOC", "${dataSummary.summary.total_boc}")),
                    SizedBox(width: 8),
                    Expanded(
                        child: textBorder(
                            "Total BOD", "${dataSummary.summary.total_bod}")),
                    SizedBox(width: 8),
                    Expanded(
                        child: textBorder("Total BOD-1",
                            "${dataSummary.summary.total_bod_minus_1}")),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Genders(
            valueLaki: "${laki2} ($persentaseLaki%)",
            valuePerempuan: "${perempuan} ($persentasePerempuan%)",
            gendersMode: GenderMode.mode1,
          ),
          SizedBox(height: 15),
          VerticalBarChart(
            modeBackground: ModeBackground.modeBackground,
            judul: "Kelompok Usia",
            nilai: [
              dataSummary.kelompok_usia.under_30,
              dataSummary.kelompok_usia.between_30_39,
              dataSummary.kelompok_usia.between_40_49,
              dataSummary.kelompok_usia.above_50,
            ],
            title: ["<30", "30-39", "40-49", ">50"],
          ),
          SizedBox(height: 15),

          // Container(
          //   child: Column(
          //     children: [
          //       Text("Agama"),
          //       Row(
          //         children: [
          //           Column(
          //             children: [
          //               Text("Agama a"),
          //               Text("Agama b"),
          //               Text("Agama c"),
          //               Text("Agama d"),
          //             ],
          //           ),
          //           SimplePieChart()
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 15),
          // ChartTitle(
          //   title: "Tingkat Pendidikan",
          // ),
          // SizedBox(height: 15),
          // ChartTitle(
          //   title: "Masa Tugas Karyawan Pada Posisi yang sama",
          // ),
          // SizedBox(height: 15),
          // GetBuilder<SummaryDashboardController>(
          //   id: 'unitMeninggal',
          //   init: SummaryDashboardController(),
          //   builder: (controller) {
          //     return Container(
          //       padding:
          //           EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          //       decoration: decorBackContainer,
          //       child: Column(
          //         children: [
          //           Text(
          //             "Karyawan Meninggal Dunia",
          //             style: font_poppins(15, FontWeight.w600),
          //           ),
          //           SizedBox(height: 10),
          //           Row(
          //             children: [
          //               text_underline_button(() {
          //                 controller.setMeninggalKondisi(0);
          //               }, "Meninggal",
          //                   (controller.meninggalKondisi == 0) ? 1 : 0),
          //               text_underline_button(() {
          //                 controller.setMeninggalKondisi(1);
          //               }, "Meninggal Karena Covid-19",
          //                   (controller.meninggalKondisi == 1) ? 1 : 0),
          //             ],
          //           ),
          //           SizedBox(height: 15),
          //           HorizontalBarChartLabel(),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(height: 15),
          // GetBuilder<SummaryDashboardController>(
          //   id: 'unitAnggaran',
          //   init: SummaryDashboardController(),
          //   builder: (controller) {
          //     return Container(
          //       padding:
          //           EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          //       decoration: decorBackContainer,
          //       child: Column(
          //         children: [
          //           Text(
          //             "Anggaran",
          //             style: font_poppins(15, FontWeight.w600),
          //           ),
          //           SizedBox(height: 10),
          //           Row(
          //             children: [
          //               text_underline_button(() {
          //                 controller.setAnggaranKondisi(0);
          //               }, "Learning and Development",
          //                   (controller.anggaranKondisi == 0) ? 1 : 0),
          //               text_underline_button(() {
          //                 controller.setAnggaranKondisi(1);
          //               }, "Inovasi Teknologi",
          //                   (controller.anggaranKondisi == 1) ? 1 : 0),
          //             ],
          //           ),
          //           SizedBox(height: 15),
          //           HorizontalBarChartLabel(),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(height: 15),
          // ChartTitle(
          //   title: "Top 10 Sebaran Suku",
          // ),
          // SizedBox(height: 15),
          // Container(
          //   child: Column(
          //     children: [
          //       Text("Agama"),
          //       Row(
          //         children: [
          //           Column(
          //             children: [
          //               Text("Agama a"),
          //               Text("Agama b"),
          //               Text("Agama c"),
          //               Text("Agama d"),
          //             ],
          //           ),
          //           SimplePieChart()
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // ChartTitle(
          //   title: "Status Pernikahan",
          // ),
        ],
      ),
    );
  }
}
