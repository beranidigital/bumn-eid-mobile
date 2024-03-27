import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';

Widget iconTextBorder(
    String title, String subtitle, String path, Function onTap) {
  return Expanded(
    flex: 1,
    child: Container(
      constraints: BoxConstraints(minHeight: 110),
      decoration: BoxDecoration(
        border: Border.all(color: color_blue, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          splashColor: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(icon, size: 33, color: color_blue),
                Image.asset("res/images/$path", scale: 0.8),
                SizedBox(height: 3),
                FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget textBorder(String title, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    decoration: BoxDecoration(
      border: Border.all(color: color_blue, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget textBorder2(String title, String value, String subValue) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: color_blue, width: 1.5),
      borderRadius: BorderRadius.circular(5),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
            child: Text(title, style: font_poppins(13.5, FontWeight.w600))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: font_poppins(15, FontWeight.bold),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            //   decoration: BoxDecoration(
            //     color: Colors.green.shade500,
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: Text(
            //     subValue,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontFamily: 'Poppins',
            //       fontSize: 10,
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    ),
  );
}

Widget textBorder3(
    String title, String subtitle, String value, String subValue) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue, width: 1.5),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: font_poppins(13, FontWeight.w500),
            ),
            Text(
              value,
              style: font_poppins(14, FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            Text(
              subValue,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
}
