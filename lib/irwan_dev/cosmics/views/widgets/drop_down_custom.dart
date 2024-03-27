import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget dropDownCustom(String value, IconData icon, String title,
    Function onChanged, List<String> list, List<String> count, int mode) {
  switch (mode) {
    case 1:
      return Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 17),
              Text(
                title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 35),
            width: Get.width,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton(
              isExpanded: true,
              value: value,
              underline: Container(),
              onChanged: onChanged,
              items: list.map((e) {
                // var index = wamen.indexOf(e);
                return DropdownMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        e,
                        style: TextStyle(fontSize: 14),
                      ),
                      // Text(totalWamen[index]),
                    ],
                  ),
                  value: e,
                );
              }).toList(),
            ),
          ),
        ],
      );
      break;
    case 2:
      return DropdownButton(
        isExpanded: true,
        value: value,
        underline: Container(),
        onChanged: onChanged,
        items: list.map((e) {
          var index = title.indexOf(e);
          return DropdownMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  e,
                  style: TextStyle(fontSize: 14),
                ),
                Text(count[index]),
              ],
            ),
            value: e,
          );
        }).toList(),
      );
      break;
  }
}
