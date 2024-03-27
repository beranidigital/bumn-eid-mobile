import 'package:flutter/material.dart';

Widget iconText(IconData icons, String title) {
  return Row(
    children: [
      Icon(icons, size: 17),
      Text(
        title,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
