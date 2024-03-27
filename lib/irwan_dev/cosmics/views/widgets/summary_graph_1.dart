import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ModeSummary { mode1, mode2, mode3 }

class SummaryGraph1 extends StatelessWidget {
  final ModeSummary modeSummary;
  List<String> path;
  List<String> value;
  List<String> title;
  SummaryGraph1({
    Key key,
    this.modeSummary,
    this.path,
    this.value,
    this.title,
  }) : super(key: key);

  Decoration _decoration(ModeSummary mode) {
    if (mode == ModeSummary.mode1) {
      return BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      );
    } else if (mode == ModeSummary.mode2) {
      return BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide(
            color: Colors.grey.withOpacity(0.0),
          ),
        ),
      );
    } else {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey, width: 0.5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: (modeSummary == ModeSummary.mode3)
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey, width: 0.5),
                    )
                  : BoxDecoration(),
              child: column_custom(
                  path[0], value[0], title[0], Colors.purple[900]),
            ),
          ),
          SizedBox(width: 9),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: _decoration(modeSummary),
              child: column_custom(path[1], value[1], title[1], Colors.green),
            ),
          ),
          SizedBox(width: 9),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: (modeSummary == ModeSummary.mode3)
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey, width: 0.5),
                    )
                  : BoxDecoration(),
              child: column_custom(path[2], value[2], title[2], Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget column_custom(String paths, String value, String title, Color warna) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon(
        //   icons,
        //   size: 27,
        //   color: warna,
        // ),
        Image.asset(paths, scale: 1),
        SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: warna),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
