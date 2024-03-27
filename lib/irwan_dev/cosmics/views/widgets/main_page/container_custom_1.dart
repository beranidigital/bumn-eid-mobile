import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/cosmics/views/pages/average_cosmi.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/event/main_event.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/perimeter/main_perimeter.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/vaksinasi/main_vaksinasi.dart';

class ContainerCustom1 extends StatelessWidget {
  int route;
  String path;
  String title;
  String value;
  ContainerCustom1({
    Key key,
    this.route,
    this.path,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (route == 1) {
            // Get.to(DetailListMainPage(
            //   text: "Mantapp",
            // ));
            // Navigator.push(
            // context, MaterialPageRoute(builder: (context) => HomePage()));
            // Get.to(HomePage());
          } else if (route == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainParimeter()));
            // Get.to(MainParimeter());
          } else if (route == 3) {
            ApiStatistic().insertStatistic("Cosmic", "Level 2 Event Page");
            // Get.to(MainEvent());
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainEvent()));
            // Get.to(MainEvent());
          } else {
            ApiStatistic().insertStatistic("Cosmic", "Level 2 Vaksinasi Page");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainVaksinasi()));
            // Get.to(MainVaksinasi());
          }
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 70),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                offset: Offset(0, 3),
                spreadRadius: 0.5,
                blurRadius: 2,
              ),
            ],
          ),
          child: new Row(
            children: <Widget>[
              // new Icon(icons, size: 27),
              new Image.asset(path, scale: 1),
              SizedBox(width: 5),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      title,
                      maxLines: 2,
                      style: new TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    new Text(
                      value,
                      style: new TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 10),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(5),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.9),
        //         blurRadius: 2,
        //         spreadRadius: 0.5,
        //         offset: Offset(0, 3),
        //       ),
        //     ],
        //   ),
        //   child: ListTile(
        //     leading: Transform.translate(
        //       offset: Offset(10, 0),
        //       child: Icon(icons, size: 40),
        //     ),
        //     title: Text(
        //       title,
        //       style: TextStyle(fontSize: 14),
        //     ),
        //     subtitle: Text(value),
        //   ),
        // ),
      ),
    );
  }

  // Widget titleSection = new Container(
  //   padding: const EdgeInsets.all(10.0), //Top, Right, Bottom, Left
  //   child: new Row(
  //     children: <Widget>[
  //       new Icon(Icons.favorite, color: Colors.red),
  //       new Expanded(
  //         child: new Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             new Container(
  //               padding: const EdgeInsets.only(bottom: 10.0),
  //               child: new Text("Programming tutorials Channel",
  //                   style: new TextStyle(
  //                       fontWeight: FontWeight.bold, fontSize: 18.0)),
  //             ),
  //             //Need to add space below this Text ?
  //             new Text(
  //               "This channel contains tutorial videos in Flutter, "
  //               "React Native, React, Angular",
  //               style: new TextStyle(color: Colors.grey[850], fontSize: 16.0),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}
