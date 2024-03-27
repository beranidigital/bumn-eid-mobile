import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/common/image_dialog/image_dialog.dart';

class ImageDialogGraph extends Graph<ImageDialog> {

  ImageDialogGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ImageDialog dependencies from injector to the instance
  @override
  void inject(ImageDialog subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
  }

  // Inside this method, we register all the ImageDialog dependencies:
  @override
  void register() {
  }
}
