import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';

class ItemMenuOne extends StatelessWidget {
  final String title;
  final String total;
  final double width;
  final double height;
  final bool click;
  final Function onTap;

  ItemMenuOne(
      {this.title,
      this.total,
      this.width,
      this.height,
      this.click,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return new GestureDetector(
      onTap: onTap,
      child: new Container(
        margin: const EdgeInsets.only(top: 10, right: 5),
        height: mediaQueryData.size.height / height,
        width: mediaQueryData.size.width / width,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: new Border.all(color: secondaryColor, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text(
                title,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
                textAlign: TextAlign.center,
              ),
              new Text(
                total,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
