import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/component/sektor_penyaluran_area/sektor_penyaluran_area_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/component/sektor_penyaluran_area/sektor_penyaluran_area_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class SektorPenyaluranAreaPageGraph extends Graph<SektorPenyaluranAreaPage> {

  SektorPenyaluranAreaPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SektorPenyaluranAreaPage dependencies from injector to the instance
  @override
  void inject(SektorPenyaluranAreaPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<SektorPenyaluranAreaActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the SektorPenyaluranAreaPage dependencies:
  @override
  void register() {
    registerDependency<SektorPenyaluranAreaActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return SektorPenyaluranAreaActionMapper(store);
    });
  }
}
