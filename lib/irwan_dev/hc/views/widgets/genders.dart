import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';

enum GenderMode { mode1, mode2 }

class Genders extends StatelessWidget {
  String valueLaki;
  String valuePerempuan;
  GenderMode gendersMode;
  Genders({
    Key key,
    this.valueLaki,
    this.valuePerempuan,
    this.gendersMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (gendersMode) {
      case GenderMode.mode1:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: decorBackContainer,
          child: Column(
            children: [
              Text(
                "Gender Perusahaan",
                style: font_poppins(15, FontWeight.w600),
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      // Icon(Icons.ac_unit, size: 30),
                      Image.asset("res/images/ic_man.png", scale: 2.5),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${valueLaki}",
                            style: font_poppins(14, FontWeight.w600),
                          ),
                          Text(
                            "Laki-laki",
                            style: font_poppins(12, FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      // Icon(Icons.ac_unit, size: 30),
                      Image.asset("res/images/ic_woman.png", scale: 2.5),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${valuePerempuan}",
                            style: font_poppins(14, FontWeight.w600),
                          ),
                          Text(
                            "Perempuan",
                            style: font_poppins(12, FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case GenderMode.mode2:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color_blue, width: 1.5),
          ),
          child: Column(
            children: [
              Text(
                "Gender Perusahaan",
                style: font_poppins(15, FontWeight.w600),
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      // Icon(Icons.ac_unit, size: 30),
                      Image.asset("res/images/ic_man.png", scale: 2.5),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${valueLaki}",
                            style: font_poppins(14, FontWeight.w600),
                          ),
                          Text(
                            "Laki-laki",
                            style: font_poppins(12, FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      // Icon(Icons.ac_unit, size: 30),
                      Image.asset("res/images/ic_woman.png", scale: 2.5),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${valuePerempuan}",
                            style: font_poppins(14, FontWeight.w600),
                          ),
                          Text(
                            "Perempuan",
                            style: font_poppins(12, FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
        break;
    }
  }
}
