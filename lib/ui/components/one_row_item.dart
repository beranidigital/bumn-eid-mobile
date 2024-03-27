import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class OneRowItem extends StatelessWidget {
  final String title;
  final String content;
  final double fontSize;
  final bool isHtml;

  OneRowItem({
    @required this.title,
    @required this.content,
    this.fontSize = 14,
    this.isHtml = false,
  });

  @override
  Widget build(BuildContext context) {
    return content == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize - 2,
                    color: Color(0xFFD8B005),
                  ),
                ),
                isHtml
                    ? Html(
                        data: content,
                        defaultTextStyle: TextStyle(
                          fontSize: fontSize,
                        ),
                      )
                    : Text(
                        content,
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
              ],
            ),
          );
  }
}
