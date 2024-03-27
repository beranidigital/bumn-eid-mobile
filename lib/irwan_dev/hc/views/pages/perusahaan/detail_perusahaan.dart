import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:bumn_eid/irwan_dev/hc/controllers/perusahaan/detail_perusahaan_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/perusahaan/detail_detail_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/perusahaan/detail_summary_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/background_stack.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/button_icon_text.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/header_bumn.dart';

class DetailPerusahaan extends StatelessWidget {
  final String idBumn;
  const DetailPerusahaan({
    Key key,
    this.idBumn,
  }) : super(key: key);
  mainWidget(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          BackgroundStack(),
          FutureBuilder<Map<String, dynamic>>(
            future: ListApiHC().getBUMNProfiles(idBumn),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hasil = snapshot.data;
                var pathPhoto =
                    hasil['logo'][0].toString().replaceAll(" ", "%20");
                return GetBuilder<DetailPerusahaanController>(
                  id: 'detailPerusahaan',
                  init: DetailPerusahaanController(),
                  builder: (controller) {
                    return Container(
                      child: ListView(
                        padding: EdgeInsets.all(12),
                        children: [
                          HeaderBumn(
                            url: '$pathPhoto',
                            title: "${hasil['name'][0]}",
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setChoiceMenu(0);
                                  },
                                  child: ButtonIconText(
                                    kondisi:
                                        (controller.choiceMenu == 0) ? 1 : 0,
                                    title: "Summary",
                                    path: (controller.choiceMenu == 0)
                                        ? "ic_summary_hc_white.png"
                                        : "ic_summary_hc.png",
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setChoiceMenu(1);
                                  },
                                  child: ButtonIconText(
                                    kondisi:
                                        (controller.choiceMenu == 1) ? 1 : 0,
                                    title: "Detail",
                                    path: (controller.choiceMenu == 1)
                                        ? "ic_detail_hc_white.png"
                                        : "ic_detail_hc.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          (controller.choiceMenu == 0)
                              ? DetailSummaryPerusahaan(idBUMN: idBumn)
                              : DetailDetailPerusahaan(idBUMN: idBumn),
                        ],
                      ),
                    );
                  },
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

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Profil BUMN",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
