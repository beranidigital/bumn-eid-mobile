import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryView1 extends StatelessWidget {
  String title;
  String value;
  double borderFirstContainer;
  double borderSecondContainer;
  double font_size;
  SummaryView1({
    Key key,
    this.title,
    this.value,
    this.borderFirstContainer,
    this.borderSecondContainer,
    this.font_size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderFirstContainer),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      width: Get.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderSecondContainer),
                topRight: Radius.circular(borderSecondContainer),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 12 + font_size,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20 + font_size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
