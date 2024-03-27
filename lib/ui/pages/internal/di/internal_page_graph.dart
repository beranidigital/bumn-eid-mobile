import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/internal/internal_page.dart';
import 'package:bumn_eid/ui/pages/internal/internal_page_action_mapper.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class InternalPageGraph extends Graph<InternalPage> {
  InternalPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the InternalPage dependencies from injector to the instance
  @override
  void inject(InternalPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.companiesController = getDependency<CompaniesController>();
  }

  // Inside this method, we register all the InternalPage dependencies:
  @override
  void register() {
    registerDependency<InternalPageActionMapper>((_) {
      final store = getDependency<Store<AppState>>();
      return InternalPageActionMapper(store);
    });
  }
}
