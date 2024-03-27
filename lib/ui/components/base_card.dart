import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final String title;

  BaseCard({
    @required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title == null
                ? Container()
                : Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
            SizedBox(
              height: 8.0,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
