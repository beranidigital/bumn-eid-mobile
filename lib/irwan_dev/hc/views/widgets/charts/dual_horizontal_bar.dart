import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/models/hc_main_page.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';

Map<String, dynamic> dataPersebaranUsiaGender = {
  "under_30": [
    {"jenis_kelamin": "L", "total": 3},
    {"jenis_kelamin": "P", "total": 2}
  ],
  "between_30_39": [
    {"jenis_kelamin": "L", "total": 84},
    {"jenis_kelamin": "P", "total": 7}
  ],
  "between_40_49": [
    {"jenis_kelamin": "L", "total": 530},
    {"jenis_kelamin": "P", "total": 74}
  ],
  "above_50": [
    {"jenis_kelamin": "L", "total": 1815},
    {"jenis_kelamin": "P", "total": 165},
    {"jenis_kelamin": "p", "total": 1}
  ]
};

List<int> safetyNull = [0, 0];

class DualHorizontalBar extends StatelessWidget {
  int nilaiTerbanyak = 0;

  KetPersebaranUsiaGender persebaranUsiaGender;
  DualHorizontalBar({
    Key key,
    this.persebaranUsiaGender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    nilaiTerbanyak = getListCountAll(persebaranUsiaGender.under_30) +
        getListCountAll(persebaranUsiaGender.between_30_39) +
        getListCountAll(persebaranUsiaGender.between_40_49) +
        getListCountAll(persebaranUsiaGender.above_50);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.45),
            offset: Offset(0, 3),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Persebaran Usia dan Gender",
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        right:
                            BorderSide(color: Colors.grey.shade400, width: 1.5),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "> 56 Tahun",
                          style: _styleText,
                        ),
                        SizedBox(height: 7),
                        Text(
                          "46 - 55 Tahun",
                          style: _styleText,
                        ),
                        SizedBox(height: 7),
                        Text(
                          "36 - 45 Tahun",
                          style: _styleText,
                        ),
                        SizedBox(height: 7),
                        Text(
                          "26 - 35 Tahun",
                          style: _styleText,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stackChart(
                              persebaranUsiaGender.above_50, nilaiTerbanyak),
                          stackChart(persebaranUsiaGender.between_40_49,
                              nilaiTerbanyak),
                          stackChart(persebaranUsiaGender.between_30_39,
                              nilaiTerbanyak),
                          stackChart(
                              persebaranUsiaGender.under_30, nilaiTerbanyak),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Opacity(
                  opacity: 0,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("36 - 45 Tahun"),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: splitToFive(nilaiTerbanyak)
                        .map((e) => Text("${e}", style: _styleText))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pointText(color_red, "Perempuan"),
              SizedBox(width: 20),
              pointText(color_blue, "Laki-laki"),
            ],
          ),
        ],
      ),
    );
  }
}

int getListCountAll(List<KetJenisKelamin> list) {
  int count = 0;
  for (int i = 0; i < list.length; i++) {
    count += list[i].total;
  }
  return count;
}

List<int> splitToFive(int nilaiTerbanyak) {
  return [
    (nilaiTerbanyak / 5).toInt(),
    (nilaiTerbanyak / 4).toInt(),
    (nilaiTerbanyak / 3).toInt(),
    (nilaiTerbanyak / 2).toInt(),
    (nilaiTerbanyak / 1).toInt()
  ];
}

TextStyle _styleText = TextStyle(
  color: Colors.grey.shade400,
  fontWeight: FontWeight.w500,
  fontSize: 12,
);

Widget stackChart(List<KetJenisKelamin> dataList, int nilaiTerbanyak) {
  print("Panjang String : ${Get.width}");
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          color: color_blue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        width: Get.width * (getValue(dataList, 1) * 100 / nilaiTerbanyak) / 100,
        height: 6,
      ),
      Container(
        decoration: BoxDecoration(
          color: color_red,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        width: Get.width * (getValue(dataList, 2) * 100 / nilaiTerbanyak) / 100,
        height: 6,
      ),
    ],
  );
}

double getValue(List<KetJenisKelamin> dataList, int kode) {
  double nilai = 0;
  for (int i = 0; i < dataList.length; i++) {
    if (dataList[i].jenis_kelamin == "L" && kode == 1) {
      nilai = dataList[i].total.toDouble();
    } else if (dataList[i].jenis_kelamin == "P" && kode == 2) {
      nilai = dataList[i].total.toDouble();
    }
  }
  return nilai;
}

Widget pointText(Color color, String text) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      SizedBox(width: 5),
      Text(text, style: _styleText),
    ],
  );
}
