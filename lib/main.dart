import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/ui/views/more_screen.dart';
import 'package:kickdown_app/ui/views/postings/postings_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart';
import 'application_state.dart';

void main() {
  setupLocator();
  runApp(KickdownApp());
}

class KickdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      title: 'Kickdown',
      initialRoute: Routes.InitialRoute,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.red,
        barBackgroundColor: Colors.white,
      ),
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
              return CupertinoPageScaffold(child: PostingsView());
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
