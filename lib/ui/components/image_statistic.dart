import 'package:flutter/material.dart';

class ImageStatistic extends StatelessWidget {
  final String image;
  final String topText;
  final String bottomText;

  ImageStatistic({
    @required this.image,
    @required this.topText,
    @required this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 30.0,
          height: 30.0,
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topText,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
              Text(
                bottomText,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
