import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/sektor_penyaluran_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/sektor_penyaluran_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class SektorPenyaluranDetailedPageGraph extends Graph<SektorPenyaluranDetailedPage> {

  SektorPenyaluranDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SektorPenyaluranDetailedPage dependencies from injector to the instance
  @override
  void inject(SektorPenyaluranDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<SektorPenyaluranDetailedActionMapper>();
    subject.csrController = getDependency<CsrController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the SektorPenyaluranDetailedPage dependencies:
  @override
  void register() {
    registerDependency<SektorPenyaluranDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return SektorPenyaluranDetailedActionMapper(store);
    });
  }
}
