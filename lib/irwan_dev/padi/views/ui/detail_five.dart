import 'package:flutter/material.dart';

import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_filter.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/search.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_list_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_one.dart';

class DetailFive extends StatelessWidget {
  final String title;
  const DetailFive({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: title,
      body: (ctx) => mainWidget(context),
    );
  }

  mainWidget(context) {
    return new ListView(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Summary",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  textBorder("Total BUMN", "123"),
                  SizedBox(width: 10),
                  textBorder("Total UMKM", "123"),
                  SizedBox(width: 10),
                  textBorder("Total Transaksi", "123"),
                ],
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Nilai",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        Text(
                          "123 T",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Eproc",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "123 T",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "B2B",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "123 T",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "B2C",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "123 T",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        // new SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: new Row(
        //     children: [
        //       ItemFilter(
        //         title: "Filter",
        //         icon: Icons.filter_list,
        //       ),
        //       ItemFilter(
        //         title: "1 Des - 20 Des 2020",
        //         icon: Icons.calendar_today_outlined,
        //       ),
        //       ItemFilter(
        //         title: "Eproc",
        //         icon: Icons.check_circle_outline,
        //       ),
        //       ItemFilter(
        //         title: "Mikro",
        //         icon: Icons.check_circle_outline,
        //       ),
        //       ItemFilter(
        //         title: "Jasa Keuangan",
        //         icon: Icons.check_circle_outline,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: 10),
        new Search(),
        new ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new ItemListOne(
              number: "${index + 1}",
              name: "Nama BUMN",
              valueOne: 2,
              valueTwo: 3,
              status: true,
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) {
                      return new DetailOne();
                    },
                  ),
                );
              },
            );
          },
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget textBorder(String title, String value) {
    return Expanded(
      flex: 1,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 60,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
