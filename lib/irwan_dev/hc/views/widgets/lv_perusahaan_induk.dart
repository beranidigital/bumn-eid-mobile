import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/models/bumn_list.dart';
import 'package:bumn_eid/irwan_dev/hc/models/count_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';

class LVPerusahaanInduk extends StatelessWidget {
  int index;
  Function onTap;
  BumnList bumnList;
  LVPerusahaanInduk({
    Key key,
    this.index,
    this.onTap,
    this.bumnList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          splashColor: Colors.grey,
          onTap: onTap,
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$index  ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "${bumnList.bumn_name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 13,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "BOC",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      "${bumnList.boc}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: color_yellow_custom,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "BOD",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      "${bumnList.bod}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: color_yellow_custom,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Karyawan",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      "${bumnList.count}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: color_yellow_custom,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: main_color_background,
                      ),
                    ],
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
