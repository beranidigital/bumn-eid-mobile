import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/modals/event_list_dialog/di/event_list_dialog_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class EventListDialog extends StatelessWidget with InjectableWidget {
  final EventListDialogGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;

  final DateTime dateTime;
  final List<Event> events;

  @override
  EventListDialogGraph graph() => _graph;

  EventListDialog({
    @required
    this.dateTime,
    @required
    this.events,
    EventListDialogGraph graph
  }) : this._graph = graph ?? EventListDialogGraph() {
    setup();
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      Icons.event,
      color: colorPalette.success,
      size: 48.0,
    );
  }

  Widget _buildTitle() {
    final formatter = DateFormat("yyyy-MM-dd");
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        "Events On: ${formatter.format(dateTime)}",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorPalette.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildEventItem(Event item) {
    final title = item.title ?? "-";
    return Text(
        "- $title",
      textAlign: TextAlign.start,
      style: TextStyle(
        color: colorPalette.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _buildEventsList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: events.length,
        itemBuilder: (context, index) => _buildEventItem(events[index])
    );
  }

  Widget _buildDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _buildIcon(context),
              _buildTitle(),
              _buildEventsList(),
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialog(context);
  }

}
