import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/filters_boc.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/boc/main_boc_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/menu_list_boc.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/menu_summary_boc.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/button_icon_text.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/text_underline_button.dart';

class MainBoc extends StatelessWidget {
  String pathEndPoint;
  MainBoc({
    Key key,
    this.pathEndPoint,
  }) : super(key: key);

  ScrollController _scrollController = new ScrollController();

  mainWidget(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.put<MainBocController>(MainBocController()).setLimitVal(40);
      }
    });

    return Container(
      child: Container(
        width: Get.width,
        height: Get.height,
        color: second_color_background,
        child: GetBuilder<MainBocController>(
          id: 'mainBoc',
          init: MainBocController(),
          builder: (controller) {
            return ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              children: [
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        controller.setChoiceView(0);
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
                        controller.setChoiceView(1);
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
                // FutureBuilder<Map<String, dynamic>>(
                //   future: ListApiHC()
                //       .getDataBOC(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       var hasil = snapshot.data;
                //       print(
                //           "Hasil JSON : ${hasil['summary']['summary']['total_boc']}");
                //       return Container();
                //     } else {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //   },
                // ),
                (controller.choiceView == 0)
                    ? MenuSummaryBoc(
                        pathEndPoint: "${pathEndPoint}${controller.path}")
                    : MenuListBox(
                        pathEndPoint: "${pathEndPoint}${controller.path}"),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BOC",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
