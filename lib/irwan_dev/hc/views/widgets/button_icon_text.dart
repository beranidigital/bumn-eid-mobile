import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';

class ButtonIconText extends StatelessWidget {
  String title;
  int kondisi;
  String path;
  ButtonIconText({
    Key key,
    this.title,
    this.kondisi,
    this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 70),
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: (kondisi == 1) ? color_blue : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.45),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset("res/images/$path", scale: 0.7),
          // Icon(Icons.ac_unit,
          // size: 35, color: (kondisi == 1) ? Colors.white : color_blue),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: (kondisi == 1) ? Colors.white : Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
