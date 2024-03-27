import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';

class BackgroundStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          Container(
            color: main_color_background,
            width: Get.width,
            height: 100,
          ),
          Expanded(
            child: Container(
              color: second_color_background,
              width: Get.width,
            ),
          ),
        ],
      ),
    );
  }
}
