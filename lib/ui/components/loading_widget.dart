import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {

  final ColorPalette colorPalette;

  LoadingWidget({
    @required
     this.colorPalette
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(colorPalette.primary),
      ),
    );
  }
}
