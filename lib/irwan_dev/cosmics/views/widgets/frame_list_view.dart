import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/card_listview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrameListView extends StatelessWidget {
  int index;
  String title;
  String value;
  String subtitle;
  FrameListView({
    Key key,
    this.index,
    this.title,
    this.value,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 1, right: 1),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: Offset(0, 3),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: CardListView(
        index: index,
        title: title,
        subtitle: subtitle,
        value: value,
      ),
    );
  }
}
