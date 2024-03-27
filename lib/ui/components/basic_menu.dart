import 'package:flutter/material.dart';

class BasicMenu extends StatelessWidget {

  final String title;
  final int total;
  final String subtitle;
  final Color bgColor;
  final Color bottomColor;
  final VoidCallback onTap;
  final Color textColor;
  final bool percentage;
  final String bottomText;
  final Color bottomTextColor;
  final String totalText;

  BasicMenu({
    @required
    this.title,
    @required
    this.total,
    @required
    this.subtitle,
    @required
    this.bgColor,
    @required
    this.bottomColor,
    @required
    this.onTap,
    this.textColor = Colors.white,
    this.bottomTextColor = Colors.white,
    this.percentage = false,
    this.bottomText = "Lihat Semua",
    this.totalText
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8)
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                Text(
                  totalText != null ? totalText : percentage ? "$total %" : total.toString(),
                  style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: bottomColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                  bottomText,
                  style: TextStyle(
                      color: bottomTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
