import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final ColorPalette colorPalette;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double imageSize;
  final Color customColor;
  final EdgeInsets padding;

  MenuCard({
    @required
    this.text,
    @required
    this.imagePath,
    @required
    this.colorPalette,
    this.onTap,
    this.height,
    this.width,
    this.imageSize = 120.0,
    this.customColor,
    this.padding = const EdgeInsets.all(16.0)
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Card(
              color: customColor ?? colorPalette.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
              ),
              elevation: 8.0,
              child: Padding(
                padding: padding,
                child: Image(
                  image: AssetImage(imagePath),
                  width: imageSize,
                  height: imageSize,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: colorPalette.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700
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
