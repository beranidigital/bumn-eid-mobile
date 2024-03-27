import 'package:flutter/material.dart';

Decoration decFormSearch = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.7),
      offset: Offset(0, 3),
      spreadRadius: 2,
      blurRadius: 2,
    ),
  ],
);

TextStyle font_poppins(double size, FontWeight fontWeight) {
  return TextStyle(
      fontSize: size, fontFamily: 'Poppins', fontWeight: fontWeight);
}

Decoration decorContainer = BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.6),
      spreadRadius: 2,
      blurRadius: 2,
      offset: Offset(0, 3),
    ),
  ],
);

Decoration decorListView = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.45),
      spreadRadius: 1,
      blurRadius: 2,
      offset: Offset(0, 3),
    ),
  ],
);

Decoration decorBackContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(6),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.45),
      offset: Offset(0, 3),
      spreadRadius: 1.5,
      blurRadius: 2,
    ),
  ],
);
