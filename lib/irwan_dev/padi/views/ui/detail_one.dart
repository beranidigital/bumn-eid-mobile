import 'package:bumn_eid/irwan_dev/padi/controllers/detail_one_controller.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_profil_bumn.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_choice_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_filter.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_list_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/search.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:get/get.dart';

class DetailOne extends StatelessWidget {
  final String title;
  const DetailOne({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: title,
      body: (ctx) => mainWidget(context),
    );
  }

  mainWidget(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      children: [
        GetBuilder<DetailOneController>(
          id: 'detailOneChoice',
          init: DetailOneController(),
          builder: (controller) {
            return new Row(
              children: [
                Expanded(
                  flex: 1,
                  child: new ItemChoiceMenu(
                    icon: Icons.apartment,
                    status: "Semua",
                    value: 100,
                    title: "BUMN",
                    kondisi: (controller.choiceView == 0) ? 1 : 0,
                    onTap: () {
                      controller.setChoiceView(0);
                    },
                  ),
                ),
                SizedBox(width: 7),
                Expanded(
                  flex: 1,
                  child: new ItemChoiceMenu(
                    icon: Icons.apartment,
                    status: "Semua",
                    value: 100,
                    title: "BUMN",
                    kondisi: (controller.choiceView == 1) ? 1 : 0,
                    onTap: () {
                      controller.setChoiceView(1);
                    },
                  ),
                ),
                SizedBox(width: 7),
                Expanded(
                  flex: 1,
                  child: new ItemChoiceMenu(
                    icon: Icons.apartment,
                    status: "Semua",
                    value: 100,
                    title: "BUMN",
                    kondisi: (controller.choiceView == 2) ? 1 : 0,
                    onTap: () {
                      controller.setChoiceView(2);
                    },
                  ),
                ),
                SizedBox(width: 7),
                Expanded(
                  flex: 1,
                  child: new ItemChoiceMenu(
                    icon: Icons.apartment,
                    status: "Semua",
                    value: 100,
                    title: "BUMN",
                    kondisi: (controller.choiceView == 3) ? 1 : 0,
                    onTap: () {
                      controller.setChoiceView(3);
                    },
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 17),
        // new SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: new Row(
        //     children: [
        //       ItemFilter(
        //         title: "Filter",
        //         icon: Icons.filter_list,
        //       ),
        //       ItemFilter(
        //         title: "1 Des - 20 Des 2020",
        //         icon: Icons.calendar_today_outlined,
        //       ),
        //       ItemFilter(
        //         title: "Eproc",
        //         icon: Icons.check_circle_outline,
        //       ),
        //       ItemFilter(
        //         title: "Mikro",
        //         icon: Icons.check_circle_outline,
        //       ),
        //       ItemFilter(
        //         title: "Jasa Keuangan",
        //         icon: Icons.check_circle_outline,
        //       ),
        //     ],
        //   ),
        // ),
        new Search(),
        new ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new ItemListOne(
              number: "${index + 1}",
              name: "Nama BUMN",
              valueOne: 2,
              valueTwo: 3,
              status: true,
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) {
                      return new DetailProfilBumn();
                    },
                  ),
                );
              },
            );
          },
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
