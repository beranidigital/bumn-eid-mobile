import 'package:flutter/material.dart';

class ItemDropdownOne extends StatefulWidget {
  final String title;
  final bool isExpanded;
  final List listItem;

  ItemDropdownOne({this.title,this.isExpanded, this.listItem});

  @override
  _ItemDropdownOneState createState() => _ItemDropdownOneState();
}

class _ItemDropdownOneState extends State<ItemDropdownOne> {
  String valueChoose;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: new BoxDecoration(
        color: Color(0xFFDDDDDD),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: new DropdownButton(
        underline: SizedBox(),
        isExpanded: widget.isExpanded,
        hint: new Text(
          widget.title,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
        ),
        value: valueChoose,
        onChanged: (newValue) {
          setState(() {
            valueChoose = newValue;
          });
        },
        items: widget.listItem.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: new Text(
              valueItem,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
