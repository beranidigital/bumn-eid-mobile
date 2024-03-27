import 'package:flutter/material.dart';

class ShadowedContainer extends StatelessWidget {
  final Widget child;

  ShadowedContainer({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.0,
            blurRadius: 4,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
