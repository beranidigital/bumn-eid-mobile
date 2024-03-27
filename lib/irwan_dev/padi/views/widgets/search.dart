import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text(
            "Pencarian",
            style: new TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                fontFamily: 'Poppins'),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: new Row(
              children: [
                new Icon(
                  Icons.search,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
