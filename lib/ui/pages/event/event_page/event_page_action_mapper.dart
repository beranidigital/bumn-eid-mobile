import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:redux/redux.dart';

class EventPageActionMapper extends ActionMapper {

  EventPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openEventsDialog(DateTime dateTime, List<Event> events) {
    if (events.isNotEmpty)
      dispatch(ShowDialogAction(destination: EventListDialogDestination(dateTime: dateTime, events: events)));
  }

}