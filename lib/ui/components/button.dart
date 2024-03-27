import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final EdgeInsets padding;
  final double elevation;

  Button({
    @required
    this.onTap,
    @required
    this.backgroundColor,
    this.textColor = Colors.white,
    @required
    this.text,
    this.padding = EdgeInsets.zero,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      padding: padding,
      color: backgroundColor,
      textColor: textColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 16.0
        ),
      ),
    );
  }
}
