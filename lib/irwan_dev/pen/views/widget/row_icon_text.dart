import 'package:flutter/material.dart';

Widget row_icon_text(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 16),
      SizedBox(width: 5),
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ],
  );
}
