import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BaseScaffold extends StatefulWidget {
  final Widget Function(BuildContext) body;
  final bool isHome;
  final bool withTopBlue;
  final String title;
  final int selectedIndex;

  BaseScaffold({
    @required this.body,
    this.isHome = false,
    this.withTopBlue = false,
    this.title,
    this.selectedIndex = 0,
  });

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  bool clickedCentreFAB =
      false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex =
      0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          this.selectedIndex = widget.selectedIndex;
          this.text = selectedIndex == 1
              ? 'Home'
              : selectedIndex == 3
                  ? 'Settings'
                  : '';
        });
      },
    );
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasClients = scrollController?.hasClients ?? false;
    final pixels = hasClients ? scrollController.position.pixels : 0;
    return Scaffold(
      appBar: widget.isHome
          ? null
          : AppBar(
              backgroundColor: Color(0xFF1F2855),
              centerTitle: true,
              elevation: 0,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
      body: SafeArea(
        child: Container(
          color: Color(0xFFf0f4fa),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: widget.withTopBlue
              ? Stack(
                  children: [
                    Positioned(
                      top: 0.0 - (pixels),
                      child: Image.asset(
                        'res/images/home_top.png',
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF1F2855),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: [
                        widget.body(context),
                      ],
                    )
                  ],
                )
              : widget.body(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!widget.isHome) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          StoreProvider.of<AppState>(context).dispatch(
            NavigateToNextAction(
              destination: NotificationPageDestination(),
            ),
          );
        },
        tooltip: "Centre FAB",
        backgroundColor: Color(0xFF134A6E),
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Image.asset(
            'res/images/ic_notification.png',
          ),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    updateTabSelection(0, "Home");
                    if (!widget.isHome) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                    StoreProvider.of<AppState>(context).dispatch(
                      NavigateToNextAndReplaceAction(
                        destination: HomePageDestination(),
                      ),
                    );
                  },
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'res/images/ic_home.png',
                          color: selectedIndex == 0
                              ? Colors.blue.shade900
                              : Colors.grey.shade400,
                          height: 24.0,
                          width: 24.0,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'HOME',
                          style: TextStyle(
                            fontFamily: 'worksans',
                            fontWeight: FontWeight.w500,
                            color: selectedIndex == 0
                                ? Colors.blue.shade900
                                : Color(0xFF6C6D6D),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              SizedBox(
                width: 50.0,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    updateTabSelection(3, "Settings");
                    if (!widget.isHome) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                    StoreProvider.of<AppState>(context).dispatch(
                      NavigateToNextAndReplaceAction(
                        destination: ProfilePageDestination(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'res/images/ic_profile.png',
                        //darken the icon if it is selected or else give it a different color
                        color: selectedIndex == 3
                            ? Colors.blue.shade900
                            : Colors.grey.shade400,
                        height: 24.0,
                        width: 24.0,
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        'PROFILE',
                        style: TextStyle(
                          fontFamily: 'worksans',
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == 3
                              ? Colors.blue.shade900
                              : Color(0xFF6C6D6D),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar
        color: Colors.white,
        notchMargin: 8.0,
      ),
    );
  }
}
