import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_bar_chart_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_container.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_information_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_line_chart.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_menu_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_menu_two.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_pie_chart_two.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class DetailThree extends StatelessWidget {
  final String title;

  DetailThree({this.title});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: title,
      body: (ctx) => mainWidget(context),
    );
  }

  mainWidget(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      children: [
        ItemContainer(
          title: "Summary",
          horizontal: true,
          widget: [
            new ItemMenuTwo(
              title: "BUMN Pemberi Pinjaman",
              total: "5",
              width: 2.4,
              height: 12,
              click: false,
            ),
            new ItemMenuTwo(
              title: "UMKM Diterima",
              total: "5",
              width: 2.4,
              height: 12,
              click: false,
            ),
            new ItemMenuOne(
              title: "Pinjaman Transaksi",
              total: "5",
              width: 3.7,
              height: 8.5,
              click: false,
            ),
            new ItemMenuOne(
              title: "Pinjaman Disalurkan",
              total: "123 JT",
              width: 3.7,
              height: 8.5,
              click: false,
            ),
            new ItemMenuOne(
              title: "Rasio Tingkat Pengembalian",
              total: "80%",
              width: 3.7,
              height: 8.5,
              click: false,
            ),
            new ItemInformationOne(
              title: "Pinjaman Luas",
            ),
            new ItemInformationOne(
              title: "Pinjaman Outstanding",
            ),
            new ItemLineChart(
              title: "Tren Pinjaman By Value",
            ),
            new ItemPieChartTwo(
              title: "Pinjaman",
            ),
            new ItemBarChartOne(
              title: "Level UMKM BY Transaksi",
            )
          ],
        )
      ],
    );
  }
}

// class DetailThree extends StatefulWidget {
//   final String title;

//   DetailThree({this.title});
//   @override
//   _DetailThreeState createState() => _DetailThreeState();
// }

// class _DetailThreeState extends State<DetailThree> {
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData mediaQueryData = MediaQuery.of(context);
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//       ),
//       body:
//     );
//   }
// }
