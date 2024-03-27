import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String title;
  final List<String> items;
  final String currentItem;
  final Function(String) onChanged;
  final double width;
  final bool withTitle;

  FilterWidget({
    this.title,
    @required this.items,
    @required this.currentItem,
    @required this.onChanged,
    this.width,
    this.withTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: EdgeInsets.only(left: 16.0, right: 8.0,),
      child: DropdownButton<String>(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        items: items.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(
              value ?? '-',
            ),
          );
        }).toList(),
        value: currentItem,
        isExpanded: true,
        underline: Container(),
        onChanged: onChanged,
      ),
    );
  }
}
