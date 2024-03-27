import 'package:bumn_eid/core/controllers/event_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/event/event_page/event_page.dart';
import 'package:bumn_eid/ui/pages/event/event_page/event_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class EventPageGraph extends Graph<EventPage> {

  EventPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the EventPage dependencies from injector to the instance
  @override
  void inject(EventPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<EventPageActionMapper>();
    subject.eventController = getDependency<EventController>();
  }

  // Inside this method, we register all the EventPage dependencies:
  @override
  void register() {
    registerDependency<EventPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return EventPageActionMapper(store);
    });
  }
}
