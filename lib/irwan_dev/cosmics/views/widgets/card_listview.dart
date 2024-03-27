import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardListView extends StatelessWidget {
  String title;
  int index;
  String subtitle;
  String value;
  CardListView({
    Key key,
    this.title,
    this.index,
    this.subtitle,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${index + 1}.  ",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            "${title}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.yellow.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
