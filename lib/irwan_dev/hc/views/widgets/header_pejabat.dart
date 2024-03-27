import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/clipper.dart';

class HeaderPejabat extends StatelessWidget {
  String name;
  String posisi;
  String name_bumn;
  String url;
  HeaderPejabat({
    Key key,
    this.name,
    this.posisi,
    this.name_bumn,
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
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  alignment: Alignment.topCenter,
                  imageUrl: url,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      posisi,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.5,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      name_bumn,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.5,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
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
