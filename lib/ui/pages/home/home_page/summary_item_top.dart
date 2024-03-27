import 'package:flutter/material.dart';

class SummaryItemTop extends StatelessWidget {
  final String title;
  final String total;

  SummaryItemTop({
    @required this.title,
    @required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Color(0xFF1FA4CA),
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.only(
        left: 24.0,
        right: 24.0,
      ),
      margin: EdgeInsets.only(
        right: 8.0,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'res/images/home_static.png',
            width: 32.0,
            height: 32.0,
          ),
          SizedBox(
            width: 16.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: Color(0xFF989696),
                ),
              ),
              Text(
                total,
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
