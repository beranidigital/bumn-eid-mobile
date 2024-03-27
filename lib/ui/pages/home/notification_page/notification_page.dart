import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/default_loading_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/pages/home/notification_page/di/notification_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class NotificationPage extends StatefulWidget with InjectableWidget {
  final NotificationPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;

  NotificationPage([graph]) : this._graph = graph ?? NotificationPageGraph() {
    setup();
  }

  @override
  NotificationPageGraph graph() => _graph;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  ScrollController scrollController;
  TextEditingController _searchController = TextEditingController();
  String currentBulan = Constants.bulanList.first;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    scrollController?.dispose();
    _searchController?.dispose();
    super.dispose();
  }

  Widget searchBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pencarian',
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        SearchBar(
          colorPalette: widget.colorPalette,
          controller: _searchController,
          onChanged: (query) => print(query),
          labelText: "",
          hintText: "Masukkan nama perusahaan.",
        ),
      ],
    );
  }

  Widget bulanFilter(BuildContext context) {
    return FilterWidget(
      currentItem: currentBulan,
      title: "Filter Bulan",
      withTitle: false,
      width: 100.0,
      items: Constants.bulanList,
      onChanged: (newBulan) {
        setState(() {
          this.currentBulan = newBulan;
        });
      },
    );
  }

  Widget notificationList(BuildContext context) {
    final notifications = [];

    if (notifications.isEmpty) {
      return Center(
        child: Text(
          'Belum ada notifikasi tersedia',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'poppins',
            color: Colors.white,
          ),
        ),
      );
    }

    return Container();
  }

  Widget mainWidget(BuildContext context) {
    final pixels =
        scrollController.hasClients ? scrollController.position.pixels : 0;

    final user =
        StoreProvider.of<AppState>(context).state.authState?.currentUser;

    if (user == null) {
      return Center(
        child: DefaultLoadingWidget(
          colorPalette: ColorPalette(),
        ),
      );
    }

    return Stack(
      children: [
        Positioned(
          top: 0.0 - (pixels),
          child: Image.asset(
            'res/images/profile_top.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            fit: BoxFit.fitWidth,
          ),
        ),
        ListView(
          controller: scrollController,
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: searchBar(context),
                ),
                SizedBox(
                  width: 8.0,
                ),
                bulanFilter(context),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            notificationList(context),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Notification',
      body: (ctx) => mainWidget(ctx),
      selectedIndex: -1,
    );
  }
}
