import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/pie_chart_legenda.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/vertical_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/models/talent_pool_summary.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/chart_title.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/genders.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/text_underline_button.dart';

class MenuSummaryTalent extends StatelessWidget {
  final String path;
  const MenuSummaryTalent({
    Key key,
    @required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TalentPoolSummary>(
      future: ListApiHC().getSummaryTalentPool(path),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var hasil = snapshot.data;

          var laki2 = 0;
          var perempuan = 0;

          if (hasil.gender.isEmpty || hasil.gender == null) {
          } else if (hasil.gender.length < 2) {
            if (hasil.gender[0].jk == "P") {
              perempuan = hasil.gender[0].total ?? 0;
            } else {
              laki2 = hasil.gender[0].total ?? 0;
            }
          } else {
            for (int i = 0; i < hasil.gender.length; i++) {
              if (hasil.gender[i].jk == "P")
                perempuan = hasil.gender[i].total;
              else if (hasil.gender[i].jk == "L") laki2 = hasil.gender[i].total;
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
                //       Icons.ac_unit,
                //       Icons.ac_unit,
                //       Icons.ac_unit,
                //       Icons.ac_unit
                //     ],
                //     title: ["Filter", "Filter", "Filter", "Filter", "Filter"],
                //   ),
                // ),
                // SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
                  decoration: decorBackContainer,
                  child: Column(
                    children: [
                      Text(
                        "Summary",
                        style: font_poppins(15, FontWeight.w600),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                              child: textBorder3(
                                  "Ready",
                                  "Not Ready",
                                  "${hasil.summary.ready}",
                                  "${hasil.summary.not_ready}")),
                          SizedBox(width: 10),
                          Expanded(
                              child: textBorder3(
                                  "Eligible",
                                  "Not Eligible",
                                  "${hasil.summary.eligible}",
                                  "${hasil.summary.not_eligible}")),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: textBorder3(
                                "Nominated",
                                "Not Nominated",
                                "${hasil.summary.nominated}",
                                "${hasil.summary.not_nominated}"),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: textBorder3(
                                "Selected",
                                "Not Selected",
                                "${hasil.summary.selected}",
                                "${hasil.summary.not_selected}"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Genders(
                  gendersMode: GenderMode.mode1,
                  valueLaki: "$laki2 ($persentaseLaki%)",
                  valuePerempuan: "$perempuan ($persentasePerempuan%)",
                ),
                SizedBox(height: 15),
                VerticalBarChart(
                  modeBackground: ModeBackground.modeBackground,
                  judul: "Kelompok Usia",
                  nilai: [
                    hasil.kelompok_usia.under_40,
                    hasil.kelompok_usia.between_41_50,
                    hasil.kelompok_usia.between_51_60,
                    hasil.kelompok_usia.above_60,
                  ],
                  title: ["<40", "41-50", "51-60", ">60"],
                ),
                SizedBox(height: 15),
                PieChartLegenda(
                  modePieChart: ModePieChart.modePeriodeBackground,
                  title: "Agama",
                  nilai: convertValueAgama(hasil.agama),
                  listView: ListView.builder(
                    padding: EdgeInsets.only(left: 15),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: hasil.agama.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: colorList[index],
                          ),
                          SizedBox(width: 7),
                          Text(
                            "${hasil.agama[index].agama} : ${hasil.agama[index].total}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

List<int> convertValueAgama(List<AgamaTalentPool> agama) {
  List<int> value = [];
  for (int i = 0; i < agama.length; i++) {
    value.add(agama[i].total);
  }
  return value;
}
