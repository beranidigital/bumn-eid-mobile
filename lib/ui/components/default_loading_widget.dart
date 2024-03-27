import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class DefaultLoadingWidget extends LoadingWidget {
  final ColorPalette colorPalette;

  DefaultLoadingWidget({@required this.colorPalette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(colorPalette.primary),
      ),
    );
  }
}
