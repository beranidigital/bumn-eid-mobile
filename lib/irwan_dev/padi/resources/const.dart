import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff134A6E);
const Color secondaryColor = Color(0xff1FA4CA);
const Color threeColor = Color(0xffD8B005);
const Color colorSecondary = Color(0xffDFDFE0);
const Color backgroundColor = Color(0xffF0F4FA);
const Color main_color_background = Color(0XFF1F2855);

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class Const {
  static String baseUrl = "https://eid.bumn.go.id";

  // static final apiKeyHeader =
  //     "\$2y\$10\$7RGoihzeUY9NBnpZvKJYM.cPXiLfLwqvCka.2pbv6FM2yzpED5LH2";
  static final apiKeyHeader =
      "\$2y\$10\$qhQoh2xJbwMuZiZCBmCf5uMgkE4AItNqd8YDZ5T5JoZ0gswprzAHG";

  static final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": apiKeyHeader,
  };
}
