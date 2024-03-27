import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/lv_perusahaan_induk.dart';

class LVPerusahaanCucu extends StatelessWidget {
  String titleInduk;
  String titleAnak;
  Function onTap;
  List<String> listPerusahaan;
  LVPerusahaanCucu({
    Key key,
    this.titleInduk,
    this.titleAnak,
    this.onTap,
    this.listPerusahaan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Divider(
                height: 35,
                thickness: 1.5,
                color: Colors.grey.shade300,
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: second_color_background,
                child: Column(
                  children: [
                    Text(
                      titleInduk,
                      style: font_poppins(13, FontWeight.w500),
                    ),
                    Text(
                      titleAnak,
                      style: font_poppins(13, FontWeight.w500),
                    ),
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listPerusahaan.length,
            itemBuilder: (context, index) {
              return LVPerusahaanInduk(
                index: index + 1,
                onTap: onTap,
              );
            },
          )
        ],
      ),
    );
  }
}
