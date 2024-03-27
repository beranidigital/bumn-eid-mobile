import 'package:flutter/material.dart';

class ItemTableOne extends StatelessWidget {
  final String title;

  ItemTableOne({this.title});
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        right: 5,
        left: 5,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: new Column(
        children: [
          new Text(
            title,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: new DataTable(
              columns: [
                DataColumn(
                  label: new Text("No"),
                ),
                DataColumn(
                  label: new Text("Level UMKM"),
                ),
                DataColumn(
                  label: new Text("Avarage"),
                ),
                DataColumn(
                  label: new Text("Minimum"),
                ),
                DataColumn(
                  label: new Text("Maksimum"),
                ),
              ],
              rows: [
                new DataRow(
                  cells: [
                    new DataCell(
                      new Text("1"),
                    ),
                    new DataCell(
                      new Text("Mikro"),
                    ),
                    new DataCell(
                      new Text("10 T"),
                    ),
                    new DataCell(
                      new Text("1.200"),
                    ),
                    new DataCell(
                      new Text("20 JT"),
                    ),
                  ],
                ),
                new DataRow(
                  cells: [
                    new DataCell(
                      new Text("2"),
                    ),
                    new DataCell(
                      new Text("Kecil"),
                    ),
                    new DataCell(
                      new Text("10 T"),
                    ),
                    new DataCell(
                      new Text("4.400"),
                    ),
                    new DataCell(
                      new Text("100 JT"),
                    ),
                  ],
                ),
                new DataRow(
                  cells: [
                    new DataCell(
                      new Text("3"),
                    ),
                    new DataCell(
                      new Text("Menengah"),
                    ),
                    new DataCell(
                      new Text("1 T"),
                    ),
                    new DataCell(
                      new Text("0"),
                    ),
                    new DataCell(
                      new Text("200 JT"),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
