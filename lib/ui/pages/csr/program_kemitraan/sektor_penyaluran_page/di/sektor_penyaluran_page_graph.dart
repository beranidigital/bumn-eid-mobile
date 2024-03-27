import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_page/sektor_penyaluran_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_page/sektor_penyaluran_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class SektorPenyaluranPageGraph extends Graph<SektorPenyaluranPage> {

  SektorPenyaluranPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SektorPenyaluranPage dependencies from injector to the instance
  @override
  void inject(SektorPenyaluranPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.csrController = getDependency<CsrController>();
    subject.actionMapper = getDependency<SektorPenyaluranActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the SektorPenyaluranPage dependencies:
  @override
  void register() {
    registerDependency<SektorPenyaluranActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return SektorPenyaluranActionMapper(store);
    });
  }
}
