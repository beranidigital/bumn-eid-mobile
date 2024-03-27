import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryView2 extends StatelessWidget {
  Color warna_background;
  Color warna_teks;
  String path;
  String title;
  String val;
  int statKond;
  SummaryView2({
    Key key,
    this.warna_background,
    this.warna_teks,
    this.path,
    this.title,
    this.val,
    this.statKond,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      width: Get.width,
      constraints: BoxConstraints(maxHeight: 80),
      decoration: BoxDecoration(
        color: warna_background,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(0, 4),
            blurRadius: 2,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(icon, size: 20, color: warna_teks),
              Image.asset(path),
              SizedBox(width: 5),
              (statKond == 1)
                  ? Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: warna_teks,
                      ),
                    )
                  : Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: warna_teks,
                        ),
                      ),
                    ),
            ],
          ),
          Text(
            val,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: warna_teks,
            ),
          ),
        ],
      ),
    );
  }
}
