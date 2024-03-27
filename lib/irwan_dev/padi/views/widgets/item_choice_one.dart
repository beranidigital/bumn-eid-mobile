import 'package:flutter/material.dart';

class ItemChoiceMenu extends StatelessWidget {
  final IconData icon;
  final String status;
  final String title;
  final int value;
  final int kondisi;
  final Function onTap;
  const ItemChoiceMenu({
    Key key,
    this.icon,
    this.status,
    this.title,
    this.value,
    this.kondisi,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
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
      child: Material(
        color: (kondisi == 1) ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Icon(
                      Icons.apartment_rounded,
                      size: 14,
                      color: (kondisi == 1) ? Colors.white : Colors.black,
                    ),
                    new Text(
                      status,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                        color: (kondisi == 1) ? Colors.white : Colors.black,
                      ),
                    )
                  ],
                ),
                new Text(
                  value.toString(),
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: (kondisi == 1) ? Colors.white : Colors.black,
                  ),
                ),
                new Text(
                  title,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: (kondisi == 1) ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
