import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/filters_boc.dart';

class FilteringList extends StatelessWidget {
  List<IconData> icon;
  List<String> title;
  Function onTap;
  FilteringList({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: title.map((e) {
        var index = title.indexOf(e);
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withOpacity(0.3),
            ),
            margin: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Icon(icon[index], size: 15),
                SizedBox(width: 4),
                Text(
                  e,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
