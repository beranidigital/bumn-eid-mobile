import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';

class ItemMenuThree extends StatelessWidget {
  final String title;
  final String total;

  final double width;

  ItemMenuThree({this.title, this.total, this.width});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return new Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      constraints: BoxConstraints(
        minHeight: 84,
      ),
      width: mediaQueryData.size.width / width,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: new Border.all(color: secondaryColor, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Text(
              title,
              style: new TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.0,
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 7),
            new Text(
              total,
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'Poppins'),
            )
          ],
        ),
      ),
    );
  }
}
