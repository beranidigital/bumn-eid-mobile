import 'dart:ui';

import 'package:bumn_eid/irwan_dev/pen/resources/clipper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderBumn extends StatelessWidget {
  String title;
  String url;
  HeaderBumn({
    Key key,
    this.title,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) => CircularProgressIndicator(),
                width: 130,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Transform.translate(
              offset: Offset(0, -1),
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: Get.width,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -8),
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: Get.width,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
