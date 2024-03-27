import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/komposisi_dewan_master_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/komposisi_dewan_master_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODKomposisiMasterPageGraph extends Graph<BODKomposisiMasterPage> {

  BODKomposisiMasterPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODKomposisiMasterPage dependencies from injector to the instance
  @override
  void inject(BODKomposisiMasterPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODKomposisiMasterActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the BODKomposisiMasterPage dependencies:
  @override
  void register() {
    registerDependency<BODKomposisiMasterActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODKomposisiMasterActionMapper(store);
    });
  }
}
