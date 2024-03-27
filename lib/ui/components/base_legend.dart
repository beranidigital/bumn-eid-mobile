import 'package:flutter/material.dart';

class BaseLegend extends StatelessWidget {
  final Color color;
  final String text;

  BaseLegend({
    @required this.text,
    this.color = const Color(0xFF00BDCC),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
          ),
          width: 10.0,
          height: 5.5,
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 11.0,
          ),
        ),
      ],
    );
  }
}
