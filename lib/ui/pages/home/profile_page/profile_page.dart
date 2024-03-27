import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/default_loading_widget.dart';
import 'package:bumn_eid/ui/pages/home/profile_page/di/profile_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget with InjectableWidget {
  final ProfilePageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;

  ProfilePage([graph]) : this._graph = graph ?? ProfilePageGraph() {
    setup();
  }

  @override
  ProfilePageGraph graph() => _graph;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ScrollController scrollController;

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
    super.dispose();
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
          ),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Profile", "Log Out Akun");
                    widget.store.dispatch(
                      ShowDialogAction(
                        destination: LogoutDestination(
                          store: widget.store,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'res/images/ic_logout.png',
                    height: 20.0,
                    width: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 75.0,
              child: Image.asset(
                'res/images/home_top_bumn.png',
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              'Panel Informasi Eksklusif',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              'Kementrian BUMN Republik Indonesia',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              'Version ${StoragePreferences.getVersionApps()}',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'res/images/profile_name.png',
                    height: 42.0,
                    width: 42.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8D9AA9),
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'res/images/profile_email.png',
                    height: 42.0,
                    width: 42.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8D9AA9),
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.35 - 50 - (pixels),
          right: MediaQuery.of(context).size.width * 0.375,
          child: Image.asset(
            'res/images/image_not_available.png',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: (ctx) => mainWidget(ctx),
      isHome: true,
      selectedIndex: 3,
    );
  }
}
