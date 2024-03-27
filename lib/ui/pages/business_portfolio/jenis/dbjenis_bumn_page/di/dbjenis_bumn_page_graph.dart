import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/dbjenis_bumn_page/dbjenis_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/dbjenis_bumn_page/dbjenis_bumn_page.dart';
import 'package:redux/redux.dart';

class DBJenisBumnPageGraph extends Graph<DBJenisBumnPage> {

  DBJenisBumnPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DBJenisBumnPage dependencies from injector to the instance
  @override
  void inject(DBJenisBumnPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<DBJenisBumnActionMapper>();
    subject.jenisController = getDependency<JenisController>();
  }

  // Inside this method, we register all the DBJenisBumnPage dependencies:
  @override
  void register() {
    registerDependency<DBJenisBumnActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return DBJenisBumnActionMapper(store);
    });
  }
}
