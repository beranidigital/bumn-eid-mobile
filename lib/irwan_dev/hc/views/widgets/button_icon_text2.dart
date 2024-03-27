import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';

class ButtonIconText2 extends StatelessWidget {
  String title;
  String value;
  int kondisi;
  Function onTap;

  ButtonIconText2({
    Key key,
    this.title,
    this.value,
    this.kondisi,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color font_color = (kondisi == 1) ? Colors.white : Colors.black;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.45),
            offset: Offset(0, 3),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: (kondisi == 1) ? color_blue : Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.apartment,
                      color: font_color,
                    ),
                    SizedBox(width: 5),
                    Text(
                      title,
                      style: TextStyle(
                        color: font_color,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 9),
                Text(
                  value,
                  style: TextStyle(
                      color: font_color,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Perusahaan",
                  style: TextStyle(
                    color: font_color,
                    fontFamily: 'Poppins',
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
