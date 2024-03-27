import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/charts/item_menu_three.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_bar_chart_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_container.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_list_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_pie_chart_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/search.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_profil_bumn.dart';

class DetailTwo extends StatelessWidget {
  final String title;

  DetailTwo({this.title});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: title,
      body: (ctx) => mainWidget(context),
    );
  }

  mainWidget(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      children: [
        new ItemContainer(
          title: "Summary UMKM Pengampu",
          horizontal: true,
          widget: [
            new ItemMenuThree(
              title: "Jumlah UMKM Registered",
              total: "1.211",
              width: 3.7,
            ),
            new ItemMenuThree(
              title: "Jumlah UMKM Activated",
              total: "1.211",
              width: 3.7,
            ),
            new ItemMenuThree(
              title: "Jumlah UMKM Listing",
              total: "1.211",
              width: 3.7,
            ),
            new ItemPieChartOne(
              title: "UMKM % Listing",
            ),
            // new HorizontalBarChart(
            //     // title: "Top 10 Pengampu UMKM",
            //     ),
          ],
        ),
        new ItemContainer(
          title: "Transaksi UMKM Binaan Pengampu",
          horizontal: true,
          widget: [
            new ItemMenuThree(
              title: "Jumlah UMKM",
              total: "1.211",
              width: 3.7,
            ),
            new ItemMenuThree(
              title: "Jumlah Transaksi",
              total: "1.211",
              width: 3.7,
            ),
            new ItemMenuThree(
              title: "Jumlah Nominal",
              total: "1.211",
              width: 3.7,
            ),
            new ItemPieChartOne(
              title: "UMKM % Listing",
            ),
            new ItemBarChartOne(
              title: "Nominal Transaksi",
            )
          ],
        ),
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
                      return new DetailProfilBumn();
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
}

// class DetailTwo extends StatefulWidget {

//   @override
//   _DetailTwoState createState() => _DetailTwoState();
// }

// class _DetailTwoState extends State<DetailTwo> {
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData mediaQueryData = MediaQuery.of(context);
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//         centerTitle: true,
//       ),
//       body:
//     );
//   }
// }
