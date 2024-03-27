import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/talent/main_talent_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/list_talent_pool.dart';
import 'package:bumn_eid/irwan_dev/hc/models/talent_pool_summary.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/menu_summary_boc.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/talent/filters_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/talent/menu_list_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/talent/menu_summary_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/button_icon_text.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';

class MainTalent extends StatelessWidget {
  String path;
  MainTalent({
    Key key,
    this.path,
  }) : super(key: key);

  ScrollController _scrollController = new ScrollController();

  mainWidget(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.put<MainTalentController>(MainTalentController()).setLimitVal(10);
      }
    });
    return Container(
      width: Get.width,
      height: Get.height,
      color: second_color_background,
      child: GetBuilder<MainTalentController>(
        id: 'mainTalent',
        init: MainTalentController(),
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
                      path: (controller.choiceView == 0)
                          ? "ic_summary_hc_white.png"
                          : "ic_summary_hc.png",
                      title: "Summary",
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
                      path: (controller.choiceView == 1)
                          ? "ic_list_white.png"
                          : "ic_list.png",
                      title: "List",
                    ),
                  ))
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FilteringList(
                  onTap: () {
                    filterTalent(context);
                  },
                  icon: controller.iconFilter,
                  title: controller.titleFilter,
                ),
              ),
              SizedBox(height: 15),
              (controller.choiceView == 0)
                  ? MenuSummaryTalent(path: "$path${controller.path}")
                  : MenuListTalent(path: "$path${controller.path}"),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Talent Pool",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
