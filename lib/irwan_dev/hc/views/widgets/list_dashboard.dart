import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';

class ListDashboard extends StatelessWidget {
  List<Function> onTap;
  String title;
  String value;
  List<String> valueList;
  ListDashboard({
    Key key,
    this.onTap,
    this.title,
    this.value,
    this.valueList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.45),
            offset: Offset(0, 3),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              iconTextBorder(
                  "Perusahaan", valueList[0], "ic_total_bumn_hc.png", onTap[0]),
              SizedBox(width: 10),
              iconTextBorder("BOC", valueList[1], "ic_boc_hc.png", onTap[1]),
              SizedBox(width: 10),
              iconTextBorder("BOD", valueList[2], "ic_bod.png", onTap[2]),
            ],
          ),
        ],
      ),
    );
  }
}
