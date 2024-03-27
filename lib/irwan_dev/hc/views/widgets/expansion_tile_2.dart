import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';

enum ModeET2 { mode1, mode2, mode3 }

class ExpansionTile2 extends StatelessWidget {
  String title;
  String titleKeahlian;
  String titleInterest;
  ModeET2 modeET2;
  String count;
  List<String> titleSub;
  List<String> isiSub;
  Widget listView;
  Widget listView1;

  ExpansionTile2({
    Key key,
    this.title,
    this.titleKeahlian,
    this.titleInterest,
    this.modeET2,
    this.count,
    this.titleSub,
    this.isiSub,
    this.listView,
    this.listView1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (modeET2) {
      case ModeET2.mode1:
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: titleSub.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(bottom: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${titleSub[index]}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: color_yellow_custom,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${isiSub[index]}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
        break;
      case ModeET2.mode2:
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
              Text(
                count,
                style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 13),
              listView,
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: listData.length,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              //       decoration: BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(
              //             width: 1,
              //             color: Colors.grey.shade400,
              //           ),
              //         ),
              //       ),
              //       child: Column(
              //         children: [],
              //       ),
              //       // ListView.builder(
              //       //   itemCount: titleSub.length,
              //       //   physics: NeverScrollableScrollPhysics(),
              //       //   shrinkWrap: true,
              //       //   itemBuilder: (context, indexx) {
              //       //     return Container(
              //       //       margin: EdgeInsets.only(bottom: 17),
              //       //       child: Column(
              //       //         crossAxisAlignment: CrossAxisAlignment.start,
              //       //         children: [
              //       //           Text(
              //       //             "${titleSub[indexx]}",
              //       //             style: TextStyle(
              //       //               fontFamily: 'Poppins',
              //       //               color: color_yellow_custom,
              //       //               fontSize: 13,
              //       //               fontWeight: FontWeight.w600,
              //       //             ),
              //       //           ),
              //       //           Text(
              //       //             "${listData[indexx][index]}",
              //       //             style: TextStyle(
              //       //               fontFamily: 'Poppins',
              //       //             ),
              //       //           ),
              //       //         ],
              //       //       ),
              //       //     );
              //       //   },
              //       // ),
              //     );
              //   },
              // ),
            ],
          ),
        );
        break;
      case ModeET2.mode3:
        return Container(
          decoration: decorBackContainer,
          margin: EdgeInsets.only(bottom: 12),
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
              Container(
                margin: EdgeInsets.only(bottom: 17, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleKeahlian,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: color_yellow_custom,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    listView,
                    Divider(thickness: 1, color: Colors.grey.shade400),
                    Text(
                      titleInterest,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: color_yellow_custom,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    listView1,
                  ],
                ),
              ),
            ],
          ),
        );
        break;
    }
  }
}
