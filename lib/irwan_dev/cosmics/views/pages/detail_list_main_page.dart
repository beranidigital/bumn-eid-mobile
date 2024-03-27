import 'dart:math' as math;

import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/detail_list_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/expansion_tile_1.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/summary_graph_1.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/summary_view_1.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailListMainPage extends StatelessWidget {
  String bumn_id;
  DetailListMainPage({
    Key key,
    this.bumn_id,
  }) : super(key: key);

  mainWidget(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: color_appbar,
                width: Get.width,
                height: 100,
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: lower_background_color,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              child: FutureBuilder<DetailListBumn>(
                future: ListApi.getDetailDataBumn(bumn_id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var hasil = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 0,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: Get.width,
                          child: Column(
                            children: [
                              Image.network('${hasil.bumn_profiles[0].logo[0]}',
                                  scale: 6),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${hasil.bumn_profiles[0].name[0]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Transform.translate(
                              offset: Offset(0, 1),
                              child: Center(
                                child: ClipPath(
                                  clipper: MyClipper(),
                                  child: Container(
                                    width: Get.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, -2),
                              child: Center(
                                child: ClipPath(
                                  clipper: MyClipper(),
                                  child: Container(
                                    width: Get.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: Get.width,
                          child: Column(
                            children: [
                              Text(
                                "Summary",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SummaryView1(
                                      title: "Cosmic Index",
                                      value:
                                          "${hasil.summary[0].cosmic_index}%",
                                      borderFirstContainer: 7,
                                      borderSecondContainer: 6,
                                      font_size: 0,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: SummaryView1(
                                      title: "Total Parameter",
                                      value:
                                          "${hasil.summary[0].total_perimeter}",
                                      borderFirstContainer: 7,
                                      borderSecondContainer: 6,
                                      font_size: 0,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: SummaryView1(
                                      title: "Total Event",
                                      value: "${hasil.summary[0].total_event}",
                                      borderFirstContainer: 7,
                                      borderSecondContainer: 6,
                                      font_size: 0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Perkembangan Kasus",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "${hasil.summaryPerkembanganKasus[0].last_updated}",
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.7),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              SummaryGraph1(
                                path: [
                                  "res/images/terdampak_cosmics.png",
                                  "res/images/sembuh_cosmics.png",
                                  "res/images/meninggal_cosmics.png"
                                ],
                                title: ["Terinfeksi", "Sembuh", "Meninggal"],
                                value: [
                                  "${hasil.summaryPerkembanganKasus[0].terinfeksi}",
                                  "${hasil.summaryPerkembanganKasus[0].sembuh}",
                                  "${hasil.summaryPerkembanganKasus[0].meninggal}"
                                ],
                                modeSummary: ModeSummary.mode3,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress Vaksin",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "${hasil.summaryProgressVaksin[0].last_updated}",
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.7),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              SummaryView1(
                                title: "Total Pegawai Divaksin",
                                value:
                                    "${hasil.summaryProgressVaksin[0].total_tervaksin}",
                                borderFirstContainer: 7,
                                borderSecondContainer: 6,
                                font_size: 0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ExpansionTile1(
                          title: "CovidSafe Protokol",
                          modeExpansionTile: ModeExpansionTile.mode1,
                          covidSafeProtokol: hasil.covidSafeProtokol,
                          icons: Icons.cloud_download,
                          kondisi: 1,
                        ),
                        SizedBox(height: 15),
                        ExpansionTile1(
                          title: "Perkembangan Kasus",
                          modeExpansionTile: ModeExpansionTile.mode2,
                          title1: "Status",
                          title2: "Total Kasus",
                          kondisi: 1,
                          perkembanganKasus: hasil.perkembangan_kasus,
                        ),
                        SizedBox(height: 15),
                        ExpansionTile1(
                          title: "Cosmic Index",
                          modeExpansionTile: ModeExpansionTile.mode2,
                          cosmicIndex: hasil.cosmic_index,
                          title1: "Tanggal",
                          title2: "Index",
                          kondisi: 2,
                        ),
                        SizedBox(height: 15),
                        ExpansionTile1(
                          title: "Pegawai Terdampak",
                          title1: "Nama",
                          title2: "Status Pegawai",
                          modeExpansionTile: ModeExpansionTile.mode2,
                          pegawaiTerdampak: hasil.pegawai_terdampak,
                          kondisi: 4,
                        ),
                        SizedBox(height: 15),
                        ExpansionTile1(
                          title: "Event",
                          modeExpansionTile: ModeExpansionTile.mode1,
                          icons: Icons.info_outline,
                          events: hasil.events,
                          kondisi: 2,
                        ),
                        SizedBox(height: 15),
                        ExpansionTile1(
                          title: "Parameter",
                          modeExpansionTile: ModeExpansionTile.mode2,
                          title1: "Kategori Parimeter",
                          kondisi: 3,
                          kategoriPerimeter: hasil.kategori_perimeters,
                          title2: "Jumlah Parimeter",
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  } else {
                    return Container(
                        width: Get.width,
                        height: Get.height,
                        child: Center(child: CircularProgressIndicator()));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BUMN",
      body: (ctx) => mainWidget(ctx),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
