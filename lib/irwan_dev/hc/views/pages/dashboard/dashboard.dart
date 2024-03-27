import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hc_main_page.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/dashboard/filter_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:core';
import 'package:bumn_eid/irwan_dev/hc/controllers/dashboard/dashboard_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/dashboard/menu_dashboard.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/dashboard/menu_summary.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/button_icon_text.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/form_search.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/list_dashboard.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class Dashboard extends StatelessWidget {
  TextEditingController _formText = TextEditingController();

  // List<IconData> _icons = [Icons.access_alarm, Icons.home];

  mainWidget(BuildContext context) {
    return Container(
        color: second_color_background,
        width: Get.width,
        height: Get.height,
        child: GetBuilder<DashboardController>(
          id: 'mainMainDashboardView',
          init: DashboardController(),
          builder: (control) {
            return FutureBuilder<HCMainPage>(
              future: ListApiHC().getSummaryDashboardHC(control.path),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var hasil = snapshot.data;
                  return GetBuilder<DashboardController>(
                    id: 'mainDashboardView',
                    init: DashboardController(),
                    builder: (controller) {
                      return ListView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        children: [
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: FormSearch(
                          //         formText: _formText,
                          //         modeForm: ModeForm.mode1,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setChoiceView(0);
                                  },
                                  child: ButtonIconText(
                                    kondisi:
                                        (controller.choiceView == 0) ? 1 : 0,
                                    title: "Menu Dashboard",
                                    path: (controller.choiceView == 0)
                                        ? "ic_dahsboard_hc_white.png"
                                        : "ic_dashboard_hc.png",
                                  ),
                                ),
                              ),
                              SizedBox(width: 13),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setChoiceView(1);
                                  },
                                  child: ButtonIconText(
                                    kondisi:
                                        (controller.choiceView == 1) ? 1 : 0,
                                    title: "Summary",
                                    path: (controller.choiceView == 1)
                                        ? "ic_summary_hc_white.png"
                                        : "ic_summary_hc.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FilteringList(
                              onTap: () {
                                filterDashboardBottomSheet(context);
                              },
                              icon: controller.iconFilter,
                              title: controller.titleFilter,
                            ),
                          ),
                          SizedBox(height: 15),
                          (controller.choiceView == 0)
                              ? MenuDashboard(
                                  dataDashboard: hasil.dahsboard,
                                )
                              : MenuSummaryDashboard(
                                  dataSummary: hasil.summary,
                                ),
                          // MenuDashboard(),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Human Capital",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
