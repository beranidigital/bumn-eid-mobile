import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:flutter/material.dart';

class ItemMenuTwo extends StatelessWidget {
  final String title;
  final String total;
  final double width;
  final double height;
  final bool click;
  final Function onTap;

  ItemMenuTwo(
      {this.title,
      this.total,
      this.width,
      this.height,
      this.onTap,
      this.click});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return new GestureDetector(
      onTap: onTap,
      child: new Container(
        margin: const EdgeInsets.only(top: 10, right: 5),
        constraints: BoxConstraints(
          minHeight: 70,
        ),
        width: mediaQueryData.size.width / width,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: new Border.all(color: secondaryColor, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              new Expanded(
                child: new Text(
                  title,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.justify,
                ),
              ),
              new Expanded(
                child: new Text(
                  total,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
