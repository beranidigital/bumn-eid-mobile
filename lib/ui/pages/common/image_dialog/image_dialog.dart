import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/common/image_dialog/di/image_dialog_graph.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ImageDialog extends StatelessWidget with InjectableWidget {
    final ImageDialogGraph _graph;

    final String image;

    //injected
    ColorPalette colorPalette;

    ImageDialog({
        @required
        this.image,
        ImageDialogGraph graph
    }) : this._graph = graph ?? ImageDialogGraph() {
        setup();
    }

    @override
    ImageDialogGraph graph() => _graph;

    @override
    Widget build(BuildContext context) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(16.0),
          child: PhotoView(
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent
            ),
              loadingBuilder: (context, _) => Container(
                width: 100.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: colorPalette.white,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(colorPalette.primary),
                      ),
                    )],
                ),
              ),
              loadFailedChild: Container(
                width: 100.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: colorPalette.white,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        Icons.error,
                        color: colorPalette.error,
                      ),
                    )],
                ),
              ),
              imageProvider: CachedNetworkImageProvider(
                  image,
              ),
          ),
        );
    }
}
