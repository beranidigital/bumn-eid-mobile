import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';

class ItemInformationOne extends StatelessWidget {
  final String title;

  ItemInformationOne({this.title});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return new Container(
      margin: const EdgeInsets.only(top: 10, right: 5),
      padding: const EdgeInsets.all(10.0),
      width: mediaQueryData.size.width / 1.2,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: new Border.all(color: secondaryColor, width: 2),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(
            title,
            style: new TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          new SizedBox(
            height: 10.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Column(
                children: [
                  new Text(
                    "Transaksi\nPinjaman",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0,
                        fontFamily: 'Poppins'),
                  ),
                  new Text(
                    "5",
                    style: new TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                ],
              ),
              new Column(
                children: [
                  new Text(
                    "Jumlah\nTransaksi",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0,
                        fontFamily: 'Poppins'),
                  ),
                  new Text(
                    "5",
                    style: new TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                ],
              ),
              new Column(
                children: [
                  new Text(
                    "Nominal\nPinjaman",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0,
                        fontFamily: 'Poppins'),
                  ),
                  new Text(
                    "5",
                    style: new TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
