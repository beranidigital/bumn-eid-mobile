import 'package:bumn_eid/irwan_dev/hc/models/profil_detail_detail_bumn.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/perusahaan/detail_perusahaan.dart';
import 'package:flutter/material.dart';

class ExpansionTile3 extends StatelessWidget {
  List<KetRelasiPerusahaan> dataList;

  String title;
  ExpansionTile3({
    Key key,
    this.dataList,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        print(
                            "Detail Profil BUMN : ${dataList[index].id_angka}");
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new DetailPerusahaan(
                              idBumn: "${dataList[index].id_angka}",
                            );
                          },
                        ));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}  ",
                              style: font_poppins(
                                13,
                                FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${dataList[index].bumn_name}",
                                style: font_poppins(
                                  14,
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: color_blue, width: 1.5),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                "Detail",
                                style:
                                    TextStyle(color: color_blue, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
