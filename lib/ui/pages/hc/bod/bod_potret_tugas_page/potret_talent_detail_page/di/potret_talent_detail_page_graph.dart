import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/potret_talent_detail_page/potret_talent_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/potret_talent_detail_page/potret_talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/talent_detail_page/talent_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/talent_detail_page/talent_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PotretTalentDetailPageGraph extends Graph<PotretTalentDetailPage> {

  PotretTalentDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PotretTalentDetailPage dependencies from injector to the instance
  @override
  void inject(PotretTalentDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.hcController = getDependency<HcController>();
    subject.actionMapper = getDependency<PotretTalentDetailActionMapper>();
  }

  // Inside this method, we register all the PotretTalentDetailPage dependencies:
  @override
  void register() {
    registerDependency<PotretTalentDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return PotretTalentDetailActionMapper(store);
    });
  }
}
