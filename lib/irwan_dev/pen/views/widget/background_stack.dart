import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          Container(
            color: color_background,
            width: Get.width,
            height: 100,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: Get.width,
            ),
          ),
        ],
      ),
    );
  }
}
