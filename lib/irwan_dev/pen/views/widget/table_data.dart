import 'package:flutter/material.dart';

class TableData extends StatelessWidget {
  List<String> title;
  TableData({
    Key key,
    this.title,
  }) : super(key: key);
  List<String> _list = [
    "mantap",
    "kali",
    "adalaj",
    "lagi",
    "goren",
    "tanpa",
    "nasi"
  ];

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: new DataTable(
        dataRowHeight: 40,
        columns: title.map((e) {
          return DataColumn(
              label: Text(
            e,
            style: TextStyle(fontSize: 19),
          ));
        }).toList(),
        rows: _list.map((e) {
          return DataRow(
            cells: title.map((e) {
              return DataCell(Text(
                e,
                style: TextStyle(fontSize: 19),
              ));
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
