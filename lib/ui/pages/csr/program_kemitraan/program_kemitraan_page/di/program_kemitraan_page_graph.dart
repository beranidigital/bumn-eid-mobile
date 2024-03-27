import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_page/program_kemitraan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_page/program_kemitraan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class ProgramKemitraanPageGraph extends Graph<ProgramKemitraanPage> {

  ProgramKemitraanPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ProgramKemitraanPage dependencies from injector to the instance
  @override
  void inject(ProgramKemitraanPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<ProgramKemitraanActionMapper>();
  }

  // Inside this method, we register all the ProgramKemitraanPage dependencies:
  @override
  void register() {
    registerDependency<ProgramKemitraanActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return ProgramKemitraanActionMapper(store);
    });
  }
}
