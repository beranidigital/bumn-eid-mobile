import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/event_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/event/event_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/event/event_page/di/event_page_graph.dart';
import 'package:bumn_eid/ui/pages/event/event_page/event_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class EventPageModel with SingleListItem {
  final String name;
  final DateTime date;

  EventPageModel({
    @required this.name,
    @required this.date,
  });

  @override
  String getTitle() {
    return name;
  }
}

// ignore: must_be_immutable
class EventPage extends StatefulWidget with InjectableWidget {
  final EventPageGraph _graph;

  EventPage([graph]) : this._graph = graph ?? EventPageGraph() {
    setup();
  }

  //injected
  ColorPalette colorPalette;
  //injected
  EventPageActionMapper actionMapper;
  //injected
  EventController eventController;
  //injected
  Store<AppState> store;

  @override
  EventPageGraph graph() => _graph;

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with AfterLayoutMixin<EventPage> {
  List<EventItem> rawData;
  EventList<Event> data;
  bool isError = false;

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null && rawData != null;
  }

  void getData() async {
    try {
      final data = await widget.eventController.fetchAllEvent();

      setState(() {
        this.rawData = data;
      });
      processData(data);
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  processData(List<EventItem> items) {
    final Map<DateTime, List<Event>> map = {};
    items.forEach((item) {
      final formattedDate = item.getDateTime();
      if (map.containsKey(formattedDate)) {
        map[formattedDate]
          ..add(Event(
              date: formattedDate, title: item.eventName, icon: _eventIcon));
      } else {
        map[formattedDate] = [
          Event(date: formattedDate, title: item.eventName, icon: _eventIcon)
        ];
      }
    });
    final EventList<Event> data = EventList<Event>(events: map);

    setState(() {
      this.data = data;
    });
  }

  Widget calendarWidget() {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: CalendarCarousel(
        onDayPressed: widget.actionMapper.openEventsDialog,
        markedDatesMap: data,
        iconColor: Color(0xFF1FA4CA),
        markedDateIconBorderColor: Color(0xFF1FA4CA),
        nextMonthDayBorderColor: Color(0xFF1FA4CA),
        prevMonthDayBorderColor: Color(0xFF1FA4CA),
        todayBorderColor: Color(0xFF1FA4CA),
        todayButtonColor: Color(0xFF1FA4CA),
      ),
    );
  }

  Widget noUpcomingEventsText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "No Upcoming Events",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: widget.colorPalette.black),
      ),
    );
  }

  Widget upcomingEventsTable(List<EventItem> items) {
    final List<EventPageModel> convertedData = [];
    items.forEach(
      (value) {
        convertedData.add(
          EventPageModel(
            name: value.eventName,
            date: DateTime.parse(value.date),
          ),
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView.builder(
        itemCount: convertedData.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, idx) {
          final data = convertedData[idx];

          return Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1FA4CA),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.date.day.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        DateFormat('MMM').format(data.date),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    data.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 24.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget upcomingEventWidget() {
    final upcomingEvents = rawData
        .where((item) => item.getDateTime().isAfter(DateTime.now()))
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Upcoming Events",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: widget.colorPalette.black),
          ),
          upcomingEvents.isEmpty
              ? noUpcomingEventsText()
              : upcomingEventsTable(upcomingEvents)
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),
                calendarWidget(),
                upcomingEventWidget(),
                LastUpdateWidget(
                  store: widget.store,
                  pageName: "event",
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Event',
      withTopBlue: true,
      body: (ctx) => SafeArea(
        child: mainWidget(ctx),
      ),
    );
  }
}
