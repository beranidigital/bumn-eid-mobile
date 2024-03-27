import 'package:flutter/material.dart';

class ContainerGradient extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget child;

  ContainerGradient(
      {this.padding,
      this.margin,
      this.height,
      this.width,
      @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF6B81E5), Color(0xFF6DA2D5)]),
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
