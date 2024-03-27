import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_talent_detail_page/dekom_anak_talent_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_talent_detail_page/dekom_anak_talent_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DekomAnakTalentDetailPageGraph extends Graph<DekomAnakTalentDetailPage> {

  DekomAnakTalentDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DekomAnakTalentDetailPage dependencies from injector to the instance
  @override
  void inject(DekomAnakTalentDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.hcController = getDependency<HcController>();
    subject.actionMapper = getDependency<DekomAnakTalentDetailActionMapper>();
  }

  // Inside this method, we register all the DekomAnakTalentDetailPage dependencies:
  @override
  void register() {
    registerDependency<DekomAnakTalentDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return DekomAnakTalentDetailActionMapper(store);
    });
  }
}
