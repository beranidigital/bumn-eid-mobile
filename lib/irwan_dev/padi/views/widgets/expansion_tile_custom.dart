import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';

class ExpansionTileCustom extends StatelessWidget {
  String title;
  String subtitle;

  List<String> dataColumn;
  String countRow;
  List<DataRow> dataRow;

  ExpansionTileCustom({
    Key key,
    this.title,
    this.subtitle,
    this.dataColumn,
    this.countRow,
    this.dataRow,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: decorBackContainer,
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
              new Container(
                // margin: const EdgeInsets.only(
                //   top: 10.0,
                //   bottom: 10.0,
                //   right: 5,
                //   left: 5,
                // ),
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: new SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: new DataTable(
                      columns: dataColumn.map((e) {
                        return DataColumn(
                          label: new Text(e),
                        );
                      }).toList()

                      // DataColumn(
                      //   label: new Text("Level UMKM"),
                      // ),
                      // DataColumn(
                      //   label: new Text("Jumlah UMKM"),
                      // ),
                      // DataColumn(
                      //   label: new Text("Jumlah Nilai"),
                      // ),
                      // DataColumn(
                      //   label: new Text("Maksimum"),
                      // ),
                      ,
                      rows: dataRow),
                ),
              ),
            ],
          ),

          // Text(
          //   count,
          //   style: TextStyle(
          //       fontSize: 14,
          //       fontStyle: FontStyle.italic,
          //       fontWeight: FontWeight.w600,
          //       fontFamily: 'Poppins'),
          // ),
          // SizedBox(height: 13),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: 14,
          //   itemBuilder: (context, index) {
          //     return Container(
          //       padding: EdgeInsets.symmetric(horizontal: 15),
          //       margin: EdgeInsets.only(bottom: 17),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Nama",
          //             style: TextStyle(
          //               fontFamily: 'Poppins',
          //               color: color_yellow_custom,
          //               fontSize: 13,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           Text(
          //             "Mantapp",
          //             style: TextStyle(
          //               fontFamily: 'Poppins',
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
