import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/bod/main_bod_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/pie_chart_legenda.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/vertical_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/genders.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/text_underline_button.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';

class MenuSummaryBod extends StatelessWidget {
  final String pathEndPoint;
  const MenuSummaryBod({
    Key key,
    this.pathEndPoint,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<Map<String, dynamic>>(
          future: ListApiHC().getDataInduk("bod?$pathEndPoint"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var summaryBOD = snapshot.data;
              var summary = summaryBOD['summary'];

              var genderPerusahaan = summaryBOD["gender_perusahaan"];
              var laki2 = 0;
              var perempuan = 0;

              if (genderPerusahaan.isEmpty || genderPerusahaan == null) {
              } else {
                perempuan = genderPerusahaan['P'];
                laki2 = genderPerusahaan['L'];
              }

              var persentaseLaki = ((laki2 + perempuan) == 0)
                  ? 0
                  : (laki2 * 100 / (laki2 + perempuan)).toInt();

              var persentasePerempuan = ((laki2 + perempuan) == 0)
                  ? 0
                  : (perempuan * 100 / (laki2 + perempuan)).toInt();

              var kl = summaryBOD['top_10']['kl'];
              var akademisi = summaryBOD['top_10']['akademisi'];
              var kbumn = summaryBOD['top_10']['kbumn'];
              var pk = summaryBOD['top_10']['pk'];

              var ormasBesar = summaryBOD['top10_ormas']['ormas_besar'];
              var partaiPolitik = summaryBOD['top10_ormas']['partai_politik'];
              var referral = summaryBOD['top10_ormas']['referral'];

              var kelompokUsia = summaryBOD['kelompok_usia'];
              var potretMasaTugas = summaryBOD['potret_masa_tugas'];
              var periodeKomisaris = summaryBOD['periode_direksi'];

              List<int> nilaiPeriodeKomisaris = [];
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
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("TOTAL BOD",
                                    style: font_poppins(13.5, FontWeight.w600)),
                                Text(
                                  "${summary['total_bod']}",
                                  style: font_poppins(15, FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(width: 17),
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 8, vertical: 1),
                          //   decoration: BoxDecoration(
                          //     color: Colors.green.shade500,
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   child: Text(
                          //     "+23",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontFamily: 'Poppins',
                          //       fontSize: 10,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: textBorder2("Laki-laki", "${laki2}", "+23")),
                        SizedBox(width: 10),
                        Expanded(
                            child: textBorder2(
                                "Perempuan", "${perempuan}", "+23")),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: textBorder2("Usia < 40 Tahun",
                                "${summary['under_40']}", "+23")),
                        SizedBox(width: 10),
                        Expanded(
                            child: textBorder2("Usia 41-50 Tahun",
                                "${summary['between_41_50']}", "+23")),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: textBorder2("Usia 51-60 Tahun",
                                "${summary['between_51_60']}", "+23")),
                        SizedBox(width: 10),
                        Expanded(
                            child: textBorder2("Usia > 60 Tahun",
                                "${summary['above_60']}", "+23")),
                      ],
                    ),
                    SizedBox(height: 15),
                    Genders(
                      gendersMode: GenderMode.mode2,
                      valueLaki: "${laki2} (${persentaseLaki}%)",
                      valuePerempuan: "${perempuan} (${persentasePerempuan}%)",
                    ),
                    SizedBox(height: 15),
                    VerticalBarChart(
                      modeBackground: ModeBackground.modeOutline,
                      judul: "Kelompok Usia",
                      nilai: [
                        kelompokUsia['under_40'],
                        kelompokUsia['between_41_50'],
                        kelompokUsia['between_51_60'],
                        kelompokUsia['above_60']
                      ],
                      title: ["<40", "41-50", "51-60", ">60"],
                    ),
                    SizedBox(height: 15),
                    GetBuilder<MainBodController>(
                      id: 'top10Kondisi',
                      init: MainBodController(),
                      builder: (controller) {
                        int ttlValue = 0;
                        List<HorBarChart> dataList = [];
                        if (controller.top10Kondisi == 0) {
                          for (int i = 0; i < kl.length; i++) {
                            ttlValue = ttlValue + kl[i]['total'];
                          }
                        } else if (controller.top10Kondisi == 1) {
                          for (int i = 0; i < akademisi.length; i++) {
                            ttlValue = ttlValue + akademisi[i]['total'];
                          }
                        } else if (controller.top10Kondisi == 2) {
                          for (int i = 0; i < kbumn.length; i++) {
                            ttlValue = ttlValue + kbumn[i]['total'];
                          }
                        } else {
                          for (int i = 0; i < pk.length; i++) {
                            ttlValue = ttlValue + pk[i]['total'];
                          }
                        }

                        if (controller.top10Kondisi == 0) {
                          for (int i = 0; i < kl.length; i++) {
                            dataList.add(
                              new HorBarChart(
                                title: kl[i]['instansi'],
                                value: kl[i]['total'],
                                totalValue: ttlValue,
                              ),
                            );
                          }
                        } else if (controller.top10Kondisi == 1) {
                          for (int i = 0; i < akademisi.length; i++) {
                            dataList.add(
                              new HorBarChart(
                                title: akademisi[i]['instansi'],
                                value: akademisi[i]['total'],
                                totalValue: ttlValue,
                              ),
                            );
                          }
                        } else if (controller.top10Kondisi == 2) {
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 9, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: color_blue, width: 1.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "TOP 10",
                                style: font_poppins(
                                  15,
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.settop10Kondisi(0);
                                    }, "K/L",
                                        (controller.top10Kondisi == 0) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.settop10Kondisi(1);
                                    }, "Akademisi",
                                        (controller.top10Kondisi == 1) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.settop10Kondisi(2);
                                    }, "Kementerian BUMN",
                                        (controller.top10Kondisi == 2) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.settop10Kondisi(3);
                                    }, "PK",
                                        (controller.top10Kondisi == 3) ? 1 : 0),
                                    // text_underline_button(() {
                                    //   controller.settop10Kondisi(4);
                                    // }, "Eksternal",
                                    //     (controller.top10Kondisi == 4) ? 1 : 0),
                                  ],
                                ),
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
                    GetBuilder<MainBodController>(
                      id: 'top10Ormas',
                      init: MainBodController(),
                      builder: (controller) {
                        int ttlValue = 0;
                        List<HorBarChart> dataList = [];
                        if (controller.top10Ormas == 0) {
                          for (int i = 0; i < ormasBesar.length; i++) {
                            ttlValue = ttlValue + ormasBesar[i]['total'];
                          }
                        } else if (controller.top10Ormas == 1) {
                          for (int i = 0; i < partaiPolitik.length; i++) {
                            ttlValue = ttlValue + partaiPolitik[i]['total'];
                          }
                        } else {
                          for (int i = 0; i < referral.length; i++) {
                            ttlValue = ttlValue + referral[i]['total'];
                          }
                        }

                        if (controller.top10Ormas == 0) {
                          for (int i = 0; i < ormasBesar.length; i++) {
                            dataList.add(
                              new HorBarChart(
                                title: ormasBesar[i]['instansi'],
                                value: ormasBesar[i]['total'],
                                totalValue: ttlValue,
                              ),
                            );
                          }
                        } else if (controller.top10Ormas == 1) {
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 9, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: color_blue, width: 1.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "TOP 10",
                                style: font_poppins(
                                  15,
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.settop10Ormas(0);
                                    }, "Ormas Besar",
                                        (controller.top10Ormas == 0) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.settop10Ormas(1);
                                    }, "Partai Politik",
                                        (controller.top10Ormas == 1) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.settop10Ormas(2);
                                    }, "Refferal",
                                        (controller.top10Ormas == 2) ? 1 : 0),
                                    // text_underline_button(() {
                                    //   controller.settop10Kondisi(3);
                                    // }, "PK", (controller.top10Kondisi == 3) ? 1 : 0),
                                    // text_underline_button(() {
                                    //   controller.settop10Kondisi(4);
                                    // }, "Eksternal",
                                    //     (controller.top10Kondisi == 4) ? 1 : 0),
                                  ],
                                ),
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
                    PieChartLegenda(
                      modePieChart: ModePieChart.modeOutline,
                      title: "Potret Masa Tugas Direksi",
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
                    // Text(periodeKomisaris.runtimeType.toString()),
                    PieChartLegenda(
                      modePieChart: ModePieChart.modePeriodeOutline,
                      title: "Periode Direksi",
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
    );
  }
}
