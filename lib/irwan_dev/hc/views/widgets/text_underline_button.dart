import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget text_underline_button(Function onTap, String text, int kondisi) {
  return Material(
    child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 3),
        decoration: (kondisi == 1)
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              )
            : BoxDecoration(),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: (kondisi == 1) ? Colors.blue : Colors.black,
          ),
        ),
      ),
    ),
  );
}
