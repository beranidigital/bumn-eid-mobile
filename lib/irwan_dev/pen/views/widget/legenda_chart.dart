import 'package:flutter/cupertino.dart';

Widget legendaChart(String title, Color warna) {
  return Row(
    children: [
      Container(
        height: 8,
        width: 20,
        color: warna,
      ),
      SizedBox(width: 5),
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
        ),
      ),
    ],
  );
}
