import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/container_gradient.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final ColorPalette colorPalette;
  final String url;

  CustomAppBar({@required this.title, @required this.colorPalette, this.url});

  bool get showUrl => url != null && Constants.debugMode;

  @override
  Widget build(BuildContext context) {
    Widget container = ContainerGradient(
      height: 78,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: colorPalette.white,
                  size: 24,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: colorPalette.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );

    if (!showUrl) return container;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        container,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            "Link: " + url ?? '-',
            style: TextStyle(fontSize: 16.0),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(!showUrl ? 52 : 120);
}
