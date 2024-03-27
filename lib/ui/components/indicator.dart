import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;
  final double fontSize;

  const Indicator(
      {Key key,
      this.color,
      this.text,
      this.isSquare = false,
      this.size = 16,
      this.textColor = const Color(0xff505050),
      this.fontSize = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: 10.0,
          color: color,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'poppins',
              color: textColor,
            ),
          ),
        )
      ],
    );
  }
}
