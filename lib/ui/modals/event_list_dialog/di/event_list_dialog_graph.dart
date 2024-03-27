import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/modals/event_list_dialog/event_list_dialog.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class EventListDialogGraph extends Graph<EventListDialog> {

  EventListDialogGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the EventListDialog dependencies from injector to the instance
  @override
  void inject(EventListDialog subject) {
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the EventListDialog dependencies:
  @override
  void register() {
  }
}
