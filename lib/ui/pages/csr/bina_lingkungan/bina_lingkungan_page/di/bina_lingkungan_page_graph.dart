import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_page/bina_lingkungan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_page/bina_lingkungan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BinaLingkunganPageGraph extends Graph<BinaLingkunganPage> {

  BinaLingkunganPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BinaLingkunganPage dependencies from injector to the instance
  @override
  void inject(BinaLingkunganPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BinaLingkunganActionMapper>();
  }

  // Inside this method, we register all the BinaLingkunganPage dependencies:
  @override
  void register() {
    registerDependency<BinaLingkunganActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return BinaLingkunganActionMapper(store);
    });
  }
}
