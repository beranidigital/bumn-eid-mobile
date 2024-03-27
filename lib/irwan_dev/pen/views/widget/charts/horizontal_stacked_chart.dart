import 'dart:math';

import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HorizontalStackedChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              decoration: _decor(Colors.red),
              margin: EdgeInsets.only(bottom: 8),
              width: 200,
              height: 30,
            ),
            Container(
              decoration: _decor(Colors.blue),
              margin: EdgeInsets.only(bottom: 8),
              width: 130,
              height: 30,
            ),
            Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Keterangan 1",
                    style: font_poppins(12, FontWeight.normal),
                  ),
                  Text(
                    "100 (1%)",
                    style: font_poppins(12, FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Decoration _decor(Color warna) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: warna,
    );
  }
}
