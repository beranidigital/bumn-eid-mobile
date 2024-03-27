import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_filter.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_list_one.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_profil_bumn.dart';

class DetailFour extends StatelessWidget {
  final String title;
  const DetailFour({
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

  mainWidget(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      children: [
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

// class DetailFour extends StatefulWidget {
//   final String title;

//   DetailFour({this.title});
//   @override
//   _DetailFourState createState() => _DetailFourState();
// }

// class _DetailFourState extends State<DetailFour> {
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
