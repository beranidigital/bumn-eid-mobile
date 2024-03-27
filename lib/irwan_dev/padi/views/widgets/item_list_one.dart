import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_profil_bumn.dart';

class ItemListOne extends StatelessWidget {
  final String number;
  final String name;
  final int valueOne;
  final int valueTwo;
  final Widget route;
  final bool status;
  Function onTap;

  ItemListOne({
    Key key,
    this.number,
    this.name,
    this.valueOne,
    this.valueTwo,
    this.route,
    this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
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
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Expanded(
                  child: new Row(
                    children: [
                      new Text(
                        number,
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                            fontFamily: 'Poppins'),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      new Expanded(
                        child: new Text(
                          name,
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              fontFamily: 'Poppins'),
                        ),
                      )
                    ],
                  ),
                ),
                new Row(
                  children: [
                    new Column(
                      children: [
                        new Text(
                          "Nominal",
                          style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            color: secondaryColor,
                          ),
                        ),
                        new Text(
                          valueOne.toString(),
                          style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            color: threeColor,
                          ),
                        )
                      ],
                    ),
                    new SizedBox(
                      width: 10.0,
                    ),
                    new Column(
                      children: [
                        new Text(
                          "UMKM",
                          style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            color: secondaryColor,
                          ),
                        ),
                        new Text(
                          valueTwo.toString(),
                          style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            color: threeColor,
                          ),
                        )
                      ],
                    ),
                    new SizedBox(
                      width: 10.0,
                    ),
                    new Icon(
                      Icons.arrow_forward,
                      color: primaryColor,
                    ),
                    // if (status == true)
                    //   new GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         new MaterialPageRoute(
                    //           builder: (context) {
                    //             return new DetailProfilBumn();
                    //           },
                    //         ),
                    //       );
                    //     },
                    //     child: new Icon(
                    //       Icons.arrow_forward,
                    //       color: primaryColor,
                    //     ),
                    //   )
                    // else
                    //   new Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
