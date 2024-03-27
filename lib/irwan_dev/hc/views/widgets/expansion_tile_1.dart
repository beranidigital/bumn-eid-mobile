import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/profil_pejabat.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/models/detail_bumn_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';

class ExpansionTile1 extends StatelessWidget {
  List<DetailBUMNTalent> dataList;

  String title;
  ExpansionTile1({
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
                        print(dataList[index].id_talenta);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new ProfilPejabat(
                              idTalent: "${dataList[index].id_talenta}",
                              jabatanBumn: "${dataList[index].jabatan}",
                              namaBumn: "${dataList[index].bumn_name}",
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
                                FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dataList[index].nama_lengkap}",
                                    style: font_poppins(
                                      13,
                                      FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${dataList[index].bumn_name}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.purple.shade700,
                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    "${dataList[index].jabatan}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: color_yellow_custom,
                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    "${dataList[index].sisa_pensiun_dalam_hari} Hari atau ${dataList[index].sisa_pensiun_tanggal_tahun} Tahun, ${dataList[index].sisa_pensiun_tanggal_bulan} Bulan",
                                    style: TextStyle(
                                        fontSize: 12, fontFamily: 'Poppins'),
                                  ),
                                ],
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
