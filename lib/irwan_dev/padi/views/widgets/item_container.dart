import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final String title;
  final bool horizontal;
  final List<Widget> widget;

  ItemContainer({this.title, this.horizontal, this.widget});
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
      ),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: new Column(
        children: [
          new Text(
            title,
            style: new TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                fontFamily: 'Poppins'),
          ),
          horizontal == true
              ? new Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: [for (var item in widget) item],
                )
              : new Column(
                  children: [for (var item in widget) item],
                ),
        ],
      ),
    );
  }
}
