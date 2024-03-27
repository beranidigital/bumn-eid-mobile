import 'package:flutter/material.dart';

class SortItem extends StatelessWidget {
  final String image;
  final String name;

  SortItem({
    @required this.image,
    @required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDDDDDD),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      margin: EdgeInsets.only(
        right: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 16.0,
            width: 16.0,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          )
        ],
      ),
    );
  }
}
