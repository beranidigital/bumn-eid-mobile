import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_detailed_page/penyebaran_wilayah_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PenyebaranWilayahDetailedPageGraph extends Graph<PenyebaranWilayahDetailedPage> {

  PenyebaranWilayahDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PenyebaranWilayahDetailedPage dependencies from injector to the instance
  @override
  void inject(PenyebaranWilayahDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.csrController = getDependency<CsrController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the PenyebaranWilayahDetailedPage dependencies:
  @override
  void register() {
  }
}
