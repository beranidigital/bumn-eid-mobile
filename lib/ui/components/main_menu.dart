import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final ColorPalette colorPalette;
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  MainMenu({
    @required this.colorPalette,
    @required this.title,
    @required this.imagePath,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      splashColor: Color(0xFF1FA4CB),
      child: Container(
        decoration: BoxDecoration(
          color: colorPalette.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.only(
          left: (size.width > 1020) ? 20.0 : 8,
          right: (size.width > 1020) ? 20.0 : 8.0,
          top: 8,
          bottom: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.035,
              ),
              child: Image(
                width: (size.width > 1020) ? 60.0 : 30.0,
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
                fontSize: (size.width > 1020) ? 20.0 : 10.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
