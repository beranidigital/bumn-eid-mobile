import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/detail_model/detail_list_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/launch_url.dart';

enum ModeExpansionTile { mode1, mode2, mode3 }

class ExpansionTile1 extends StatelessWidget {
  final ModeExpansionTile modeExpansionTile;
  String title;
  String title1;
  String title2;
  int kondisi;
  List<Events> events;
  List<PegawaiTerdampak> pegawaiTerdampak;
  List<CovidSafeProtokol> covidSafeProtokol;
  List<PerkembanganKasus> perkembanganKasus;
  List<CosmicIndex> cosmicIndex;
  List<KategoriPerimeters> kategoriPerimeter;
  IconData icons;
  ExpansionTile1({
    Key key,
    this.modeExpansionTile,
    this.title,
    this.title1,
    this.title2,
    this.kondisi,
    this.events,
    this.pegawaiTerdampak,
    this.covidSafeProtokol,
    this.perkembanganKasus,
    this.cosmicIndex,
    this.kategoriPerimeter,
    this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(1, 2.5),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        children: [
          expansionTileMode(),
        ],
      ),
    );
  }

  Widget expansionTileMode() {
    switch (modeExpansionTile) {
      case ModeExpansionTile.mode1:
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 17),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount:
                  (kondisi == 1) ? covidSafeProtokol.length : events.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      (kondisi == 1)
                          // ? print(covidSafeProtokol[index].filepath)
                          ? launchUrl(covidSafeProtokol[index].filepath)
                          : print(events[index].id);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text((kondisi == 1)
                              ? covidSafeProtokol[index].protokol
                              : events[index].nama_kegiatan),
                        ),
                        Icon(icons),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        );
        break;
      case ModeExpansionTile.mode2:
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 17),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "No",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "$title1",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "$title2",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (kondisi == 1)
                  ? perkembanganKasus.length
                  : (kondisi == 2)
                      ? cosmicIndex.length
                      : (kondisi == 3)
                          ? kategoriPerimeter.length
                          : (pegawaiTerdampak.length > 25)
                              ? 25
                              : pegawaiTerdampak.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text("${index + 1}"),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          (kondisi == 1)
                              ? "${perkembanganKasus[index].status_kasus2}"
                              : (kondisi == 2)
                                  ? "${cosmicIndex[index].tanggal}"
                                  : (kondisi == 3)
                                      ? "${kategoriPerimeter[index].kategori}"
                                      // : "${pegawaiTerdampak[index].nama}",
                                      : "${secureName(pegawaiTerdampak[index].nama)}",
                        ),
                      ),
                      Text(
                        (kondisi == 1)
                            ? "${perkembanganKasus[index].total}"
                            : (kondisi == 2)
                                ? "${cosmicIndex[index].cosmic_index}"
                                : (kondisi == 3)
                                    ? "${kategoriPerimeter[index].total}"
                                    : "${pegawaiTerdampak[index].status_kasus2}",
                      ),
                    ],
                  ),
                );
              },
            ),
            // Text("${secureName("Irwan Ardyansah")}"),
            //   ],
            // ),
            SizedBox(height: 20),
          ],
        );
        break;
      case ModeExpansionTile.mode3:
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 17),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("dicoba ces"),
            Text("aii tidak adami"),
            SizedBox(height: 20),
          ],
        );
        break;
    }
  }
}

String secureName(String name) {
  String name_changes = "";
  // name_changes = name;
  if (name.split(" ").length > 1) {
    name_changes = name_changes + name.split(" ")[0].substring(0, 1);
    name_changes = name_changes + name.split(" ")[1].substring(0, 1);
  } else {
    if (name.split(" ")[0] == 1) {
      name_changes = name_changes + name.split(" ")[1].substring(0, 1);
      name_changes = name_changes +
          name.split(" ")[1].substring(
              name.split(" ")[1].length - 1, name.split(" ")[1].length);
    } else {
      name_changes = name_changes + name.split(" ")[0].substring(0, 1);
      name_changes = name_changes +
          name.split(" ")[0].substring(
              name.split(" ")[0].length - 1, name.split(" ")[0].length);
    }
  }

  return name_changes;
}
