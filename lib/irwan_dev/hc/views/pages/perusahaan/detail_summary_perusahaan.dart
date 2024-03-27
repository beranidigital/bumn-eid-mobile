import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/models/profil_detail_summary_bumn.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/dual_horizontal_bar.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:bumn_eid/irwan_dev/hc/controllers/perusahaan/detail_perusahaan_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/button_icon_text.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/chart_title.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/pie_chart_legenda.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/vertical_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/genders.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/single_hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/text_underline_button.dart';

class DetailSummaryPerusahaan extends StatelessWidget {
  final String idBUMN;
  DetailSummaryPerusahaan({
    Key key,
    this.idBUMN,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<SummaryProfilBUMN>(
        future: ListApiHC().getSummaryBUMNProfiles(idBUMN),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var hasil = snapshot.data;

            var laki2 = 0;
            var perempuan = 0;

            if (hasil.gender_perusahaan.length == 0 ||
                hasil.gender_perusahaan.isEmpty) {
            } else if (hasil.gender_perusahaan.length < 2) {
              if (hasil.gender_perusahaan[0].jenis_kelamin == "P") {
                perempuan = hasil.gender_perusahaan[0].total ?? 0;
              } else {
                laki2 = hasil.gender_perusahaan[0].total ?? 0;
              }
            } else {
              for (int i = 0; i < hasil.gender_perusahaan.length; i++) {
                if (hasil.gender_perusahaan[i].jenis_kelamin == "P")
                  perempuan = hasil.gender_perusahaan[i].total;
                else if (hasil.gender_perusahaan[i].jenis_kelamin == "L")
                  laki2 = hasil.gender_perusahaan[i].total;
              }
            }

            var persentaseLaki = ((laki2 + perempuan) == 0)
                ? 0
                : (laki2 * 100 / (laki2 + perempuan)).toInt();
            var persentasePerempuan = ((laki2 + perempuan) == 0)
                ? 0
                : (perempuan * 100 / (laki2 + perempuan)).toInt();

            return Column(
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
                // SizedBox(height: 15),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 9),
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
                              child: textBorder("Total Perusahaan",
                                  "${hasil.total_perusahaan}")),
                          SizedBox(width: 10),
                          Expanded(
                              child: textBorder("Total Anggaran HC",
                                  "${hasil.total_anggaran_hc}")),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                              "${hasil.total_karyawan_hc}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: textBorder(
                                  "Total BOC\n", "${hasil.total_boc}")),
                          SizedBox(width: 10),
                          Expanded(
                              child: textBorder(
                                  "Total BOD HC\n", "${hasil.total_bod}")),
                          SizedBox(width: 10),
                          Expanded(
                              child: textBorder("Total BOD-1\n",
                                  "${hasil.total_bod_minus_1}")),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GetBuilder<DetailPerusahaanController>(
                  id: 'subDetailPerusahaan',
                  init: DetailPerusahaanController(),
                  builder: (controller) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setChoiceSubMenu(0);
                                  },
                                  child: ButtonIconText(
                                    kondisi:
                                        (controller.choiceSubMenu == 0) ? 1 : 0,
                                    title: "Komposisi BOC",
                                    path: (controller.choiceSubMenu == 0)
                                        ? "small_white_cosmics.png"
                                        : "ic_building_hc.png",
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setChoiceSubMenu(1);
                                  },
                                  child: ButtonIconText(
                                    kondisi:
                                        (controller.choiceSubMenu == 1) ? 1 : 0,
                                    title: "Komposisi BOD",
                                    path: (controller.choiceSubMenu == 1)
                                        ? "small_white_cosmics.png"
                                        : "ic_building_hc.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          DualHorizontalBar(
                              persebaranUsiaGender:
                                  hasil.persebaran_usia_gender),
                          SizedBox(height: 15),
                          Genders(
                            valueLaki: "$laki2 ($persentaseLaki%)",
                            valuePerempuan:
                                "$perempuan ($persentasePerempuan%)",
                            gendersMode: GenderMode.mode1,
                          ),
                          SizedBox(height: 15),
                          VerticalBarChart(
                            modeBackground: ModeBackground.modeBackground,
                            judul: "Kelompok Usia",
                            nilai: [
                              hasil.kelompok_usia.under_30,
                              hasil.kelompok_usia.between_30_39,
                              hasil.kelompok_usia.between_40_49,
                              hasil.kelompok_usia.above_50,
                            ],
                            title: ["<30", "30-39", "40-49", ">50"],
                          ),
                          SizedBox(height: 15),
                          SingleHorBarChart(
                            title: "Tingkat Pendidikan",
                            listData:
                                tingkatPendidikan(hasil.tingkat_pendidikan),
                          ),
                          SizedBox(height: 15),
                          SingleHorBarChart(
                            title: "Top 10 Persebaran Suku",
                            listData: top10Suku(hasil.top10_suku),
                          ),
                          SizedBox(height: 15),
                          PieChartLegenda(
                            modePieChart: ModePieChart.modePeriodeBackground,
                            title: "Golongan Darah",
                            nilai: convertDataNilai(hasil.golongan_darah),
                            listView: ListView.builder(
                              padding: EdgeInsets.only(left: 15),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: hasil.golongan_darah.length,
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
                                      "Gol-Dar ${hasil.golongan_darah[index].golongan_darah} : ${hasil.golongan_darah[index].total}",
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
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

List<HorBarChart> tingkatPendidikan(List<TingkatPendidikanProfilBUM> dataList) {
  int totalValue = 0;
  for (int i = 0; i < dataList.length; i++) totalValue += dataList[i].total;

  List<HorBarChart> data = [];
  for (int i = 0; i < dataList.length; i++) {
    data.add(
      new HorBarChart(
        title: dataList[i].nama,
        value: dataList[i].total,
        totalValue: totalValue,
      ),
    );
  }
  return data;
}

List<HorBarChart> top10Suku(List<TopSukuProfilBUMN> dataList) {
  int totalValue = 0;
  for (int i = 0; i < dataList.length; i++) totalValue += dataList[i].total;

  List<HorBarChart> data = [];
  for (int i = 0; i < dataList.length; i++) {
    data.add(
      new HorBarChart(
        title: dataList[i].suku,
        value: dataList[i].total,
        totalValue: totalValue,
      ),
    );
  }
  return data;
}

List<int> convertDataNilai(List<GolDarProfilBUMN> dataList) {
  List<int> nilai = [];
  for (int i = 0; i < dataList.length; i++) nilai.add(dataList[i].total);
  return nilai;
}
