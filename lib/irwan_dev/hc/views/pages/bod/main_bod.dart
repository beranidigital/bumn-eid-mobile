import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/bod/main_bod_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/bod/filters_bod.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/bod/menu_list_bod.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/bod/menu_summary_bod.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/button_icon_text.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';

class MainBod extends StatelessWidget {
  String pathEndPoint;
  MainBod({
    Key key,
    this.pathEndPoint,
  }) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  mainWidget(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.put<MainBodController>(MainBodController()).setLimitVal(40);
      }
    });
    return Container(
      child: Container(
        width: Get.width,
        height: Get.height,
        color: second_color_background,
        child: GetBuilder<MainBodController>(
          id: 'mainBod',
          init: MainBodController(),
          builder: (controller) {
            return ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              children: [
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        controller.setVoiceView(0);
                      },
                      child: ButtonIconText(
                        kondisi: (controller.choiceView == 0) ? 1 : 0,
                        title: "Summary",
                        path: (controller.choiceView == 0)
                            ? "ic_summary_hc_white.png"
                            : "ic_summary_hc.png",
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        controller.setVoiceView(1);
                      },
                      child: ButtonIconText(
                        kondisi: (controller.choiceView == 1) ? 1 : 0,
                        title: "List",
                        path: (controller.choiceView == 1)
                            ? "ic_list_white.png"
                            : "ic_list.png",
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FilteringList(
                    onTap: () {
                      bottomSheetDialog(context);
                    },
                    icon: controller.iconFilter,
                    title: controller.titleFilter,
                  ),
                ),
                SizedBox(height: 15),
                (controller.choiceView == 0)
                    ? MenuSummaryBod(
                        pathEndPoint: "${pathEndPoint}${controller.path}")
                    : MenuListBod(
                        pathEndPoint: "${pathEndPoint}${controller.path}"),
              ],
            );
          },
        ),
        // FutureBuilder<Map<String, dynamic>>(
        //   future: ListApiHC().getDataBODInduk(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       var hasil = snapshot.data;

        //     } else {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BOD",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
