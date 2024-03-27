import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownCustom extends StatelessWidget {
  List<String> listValue;
  Function onChanged;
  String value;
  DropDownCustom({
    Key key,
    this.listValue,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        items: listValue.map((e) {
          return DropdownMenuItem(
            child: Text(
              e,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
            ),
            value: e,
          );
        }).toList(),
      ),
    );
  }
}
