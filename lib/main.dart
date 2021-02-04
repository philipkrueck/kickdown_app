import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/screens/postings_screen.dart';
import 'package:kickdown_app/screens/more_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      lazy: false,
      create: (context) {
        return ApplicationState();
      },
      builder: (context, _) => KickdownApp(),
    ),
  );
}

class KickdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      title: 'Hello',
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.red,
        barBackgroundColor: Colors.white,
      ),
      home: TabNavigation(),
    );
  }
}

class TabNavigation extends StatelessWidget {
  final overviewNormalTabIcon =
      TabBarIcon(path: 'assets/ic_menu_overview_normal.png');
  final overviewSelectedTabIcon =
      TabBarIcon(path: 'assets/ic_menu_overview_selected.png');
  final moreNormalTabIcon = TabBarIcon(path: 'assets/ic_menu_more_normal.png');
  final moreSelectedTabIcon =
      TabBarIcon(path: 'assets/ic_menu_more_selected.png');

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            label: 'Angebote',
            icon: overviewNormalTabIcon,
            activeIcon: overviewSelectedTabIcon,
          ),
          BottomNavigationBarItem(
            label: 'Mehr',
            icon: moreNormalTabIcon,
            activeIcon: moreSelectedTabIcon,
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        CupertinoTabView returnValue;
        if (index == 0) {
          returnValue = CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: PostingsScreen());
            },
          );
        } else {
          returnValue = CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                child: MoreScreen(),
              );
            },
          );
        }
        return returnValue;
      },
    );
  }
}

class TabBarIcon extends StatelessWidget {
  final String path;
  TabBarIcon({this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      // TODO: apply style as an icon
      path,
      width: 24,
      height: 24,
      color: IconTheme.of(context).color,
    );
  }
}
