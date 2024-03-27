import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/boc/main_boc_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/pie_chart_legenda.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_pie_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/vertical_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/genders.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/text_underline_button.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';

class MenuSummaryBoc extends StatelessWidget {
  final String pathEndPoint;
  const MenuSummaryBoc({
    Key key,
    this.pathEndPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: ListApiHC().getDataInduk("boc?${pathEndPoint}"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var dataSummary = snapshot.data;
                var summary = dataSummary['summary'];
                var kl = dataSummary['top_10']['kl'];
                var akademisi = dataSummary['top_10']['akademisi'];
                var kbumn = dataSummary['top_10']['kbumn'];
                var pk = dataSummary['top_10']['pk'];

                var ormasBesar = dataSummary["top10_ormas"]['ormas_besar'];
                var partaiPolitik =
                    dataSummary["top10_ormas"]['partai_politik'];
                var referral = dataSummary["top10_ormas"]['referral'];

                var kelompokUsia = dataSummary["kelompok_usia"];

                var genderPerusahaan = dataSummary["gender_perusahaan"];
                var laki2 = 0;
                var perempuan = 0;

                if (genderPerusahaan.length == 0 ||
                    genderPerusahaan.isEmpty ||
                    genderPerusahaan == null) {
                } else if (genderPerusahaan.length < 2) {
                  if (genderPerusahaan[0]['jenis_kelamin'] == "P") {
                    perempuan = genderPerusahaan[0]['total'] ?? 0;
                  } else {
                    laki2 = genderPerusahaan[0]['total'] ?? 0;
                  }
                } else {
                  for (int i = 0; i < genderPerusahaan.length; i++) {
                    if (genderPerusahaan[i]['jenis_kelamin'] == "P")
                      perempuan = genderPerusahaan[i]['total'];
                    else if (genderPerusahaan[i]['jenis_kelamin'] == "L")
                      laki2 = genderPerusahaan[i]['total'];
                  }
                }

                var persentaseLaki = ((laki2 + perempuan) == 0)
                    ? 0
                    : (laki2 * 100 / (laki2 + perempuan)).toInt();
                var persentasePerempuan = ((laki2 + perempuan) == 0)
                    ? 0
                    : (perempuan * 100 / (laki2 + perempuan)).toInt();

                List<int> nilaiPeriodeKomisaris = [];
                var potretMasaTugas = dataSummary['potret_masa_tugas'];
                var periodeKomisaris = dataSummary['periode_komisaris'];
                for (int i = 0; i < periodeKomisaris.length; i++) {
                  nilaiPeriodeKomisaris.add(periodeKomisaris[i]['total']);
                }
                return Container(
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
                              child: textBorder2("Total BOC",
                                  "${summary['total_boc']}", "+23")),
                          SizedBox(width: 10),
                          Expanded(
                              child: textBorder2("Total K/L",
                                  "${summary['total_kl']}", "+23")),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: textBorder2("Kementerian BUMN",
                                  "${summary['total_kbumn']}", "+23")),
                          SizedBox(width: 10),
                          Expanded(
                              child: textBorder2("Ormas dan Lainnya",
                                  "${summary['total_ormas_lainnya']}", "+23")),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: textBorder2("Professional Koperasi (PK)",
                                  "${summary['total_pk']}", "+23")),
                          SizedBox(width: 10),
                          Expanded(
                              child: textBorder2("Akademisi",
                                  "${summary['total_akademisi']}", "+23")),
                        ],
                      ),
                      SizedBox(height: 15),
                      GetBuilder<MainBocController>(
                        id: 'top10Boc',
                        init: MainBocController(),
                        builder: (controller) {
                          int ttlValue = 0;
                          List<HorBarChart> dataList = [];
                          if (controller.choiceTop10 == 0) {
                            for (int i = 0; i < kl.length; i++) {
                              ttlValue = ttlValue + kl[i]['total'];
                            }
                          } else if (controller.choiceTop10 == 1) {
                            for (int i = 0; i < akademisi.length; i++) {
                              ttlValue = ttlValue + akademisi[i]['total'];
                            }
                          } else if (controller.choiceTop10 == 2) {
                            for (int i = 0; i < kbumn.length; i++) {
                              ttlValue = ttlValue + kbumn[i]['total'];
                            }
                          } else {
                            for (int i = 0; i < pk.length; i++) {
                              ttlValue = ttlValue + pk[i]['total'];
                            }
                          }

                          if (controller.choiceTop10 == 0) {
                            for (int i = 0; i < kl.length; i++) {
                              dataList.add(
                                new HorBarChart(
                                  title: kl[i]['instansi'],
                                  value: kl[i]['total'],
                                  totalValue: ttlValue,
                                ),
                              );
                            }
                          } else if (controller.choiceTop10 == 1) {
                            for (int i = 0; i < akademisi.length; i++) {
                              dataList.add(
                                new HorBarChart(
                                  title: akademisi[i]['instansi'],
                                  value: akademisi[i]['total'],
                                  totalValue: ttlValue,
                                ),
                              );
                            }
                          } else if (controller.choiceTop10 == 2) {
                            for (int i = 0; i < kbumn.length; i++) {
                              dataList.add(
                                new HorBarChart(
                                  title: kbumn[i]['instansi'],
                                  value: kbumn[i]['total'],
                                  totalValue: ttlValue,
                                ),
                              );
                            }
                          } else {
                            for (int i = 0; i < pk.length; i++) {
                              dataList.add(
                                new HorBarChart(
                                  title: pk[i]['instansi'],
                                  value: pk[i]['total'],
                                  totalValue: ttlValue,
                                ),
                              );
                            }
                          }

                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 9, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: color_blue, width: 1.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Top 10",
                                  style: font_poppins(15, FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setChoiceTop10(0);
                                    }, "K/L",
                                        (controller.choiceTop10 == 0) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.setChoiceTop10(1);
                                    }, "Akademisi",
                                        (controller.choiceTop10 == 1) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.setChoiceTop10(2);
                                    }, "Kementerian BUMN",
                                        (controller.choiceTop10 == 2) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.setChoiceTop10(3);
                                    }, "PK",
                                        (controller.choiceTop10 == 3) ? 1 : 0),
                                  ],
                                ),
                                SizedBox(height: 15),
                                HorizontalBarChartLabel(
                                  list: dataList,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      GetBuilder<MainBocController>(
                        id: 'topOrmas',
                        init: MainBocController(),
                        builder: (controller) {
                          int ttlValue = 0;
                          List<HorBarChart> dataList = [];
                          if (controller.choiceOrmas == 0) {
                            for (int i = 0; i < ormasBesar.length; i++) {
                              ttlValue = ttlValue + ormasBesar[i]['total'];
                            }
                          } else if (controller.choiceOrmas == 1) {
                            for (int i = 0; i < partaiPolitik.length; i++) {
                              ttlValue = ttlValue + partaiPolitik[i]['total'];
                            }
                          } else {
                            for (int i = 0; i < referral.length; i++) {
                              ttlValue = ttlValue + referral[i]['total'];
                            }
                          }

                          if (controller.choiceOrmas == 0) {
                            for (int i = 0; i < ormasBesar.length; i++) {
                              dataList.add(
                                new HorBarChart(
                                  title: ormasBesar[i]['instansi'],
                                  value: ormasBesar[i]['total'],
                                  totalValue: ttlValue,
                                ),
                              );
                            }
                          } else if (controller.choiceOrmas == 1) {
                            for (int i = 0; i < partaiPolitik.length; i++) {
                              dataList.add(
                                new HorBarChart(
                                  title: partaiPolitik[i]['instansi'],
                                  value: partaiPolitik[i]['total'],
                                  totalValue: ttlValue,
                                ),
                              );
                            }
                          } else {
                            for (int i = 0; i < referral.length; i++) {
                              dataList.add(
                                new HorBarChart(
                                  title: referral[i]['instansi'],
                                  value: referral[i]['total'],
                                  totalValue: ttlValue,
                                ),
                              );
                            }
                          }
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 9, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: color_blue, width: 1.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Top 10 Ormas dan Lainnya",
                                  style: font_poppins(15, FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setChoiceOrmas(0);
                                    }, "Ormas Besar",
                                        (controller.choiceOrmas == 0) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.setChoiceOrmas(1);
                                    }, "Partai Politik",
                                        (controller.choiceOrmas == 1) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.setChoiceOrmas(2);
                                    }, "Referral",
                                        (controller.choiceOrmas == 2) ? 1 : 0),
                                  ],
                                ),
                                SizedBox(height: 15),
                                HorizontalBarChartLabel(
                                  list: dataList,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      Genders(
                        valueLaki: "$laki2 ($persentaseLaki%)",
                        valuePerempuan: "$perempuan ($persentasePerempuan%)",
                        gendersMode: GenderMode.mode2,
                      ),
                      SizedBox(height: 15),
                      VerticalBarChart(
                        modeBackground: ModeBackground.modeOutline,
                        judul: "Kelompok Usia",
                        nilai: [
                          kelompokUsia['under_30'],
                          kelompokUsia['between_30_39'],
                          kelompokUsia['between_40_49'],
                          kelompokUsia['above_50']
                        ],
                        title: ["<30", "30-39", "40-49", ">50"],
                      ),
                      SizedBox(height: 15),
                      PieChartLegenda(
                        modePieChart: ModePieChart.modeOutline,
                        title: "Potret Masa Tugas Komisaris",
                        variabel: [
                          "<1 Tahun",
                          "1-2 Tahun",
                          "2-3 Tahun",
                          "3-4 Tahun",
                          "4-5 Tahun"
                        ],
                        nilai: [
                          potretMasaTugas['below_1_year'],
                          potretMasaTugas['between_1_2_year'],
                          potretMasaTugas['between_2_3_year'],
                          potretMasaTugas['between_3_4_year'],
                          potretMasaTugas['between_4_5_year'],
                        ],
                      ),
                      SizedBox(height: 15),
                      PieChartLegenda(
                        modePieChart: ModePieChart.modePeriodeOutline,
                        title: "Periode Komisaris",
                        nilai: nilaiPeriodeKomisaris,
                        listView: ListView.builder(
                          padding: EdgeInsets.only(left: 15),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: periodeKomisaris.length,
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
                                  "Periode ${periodeKomisaris[index]['periode']} : ${periodeKomisaris[index]['total']}",
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
