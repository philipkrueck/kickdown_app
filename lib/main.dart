import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/screens/listings_screen.dart';
import 'package:kickdown_app/screens/settings_screen.dart';

void main() {
  runApp(KickdownApp());
}

class KickdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hello',
      theme: CupertinoThemeData(
        primaryColor: Colors.red,
      ),
      home: TabNavigation(),
    );
  }
}

class TabNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              label: 'Angebote', icon: Icon(Icons.car_rental)),
          BottomNavigationBarItem(
              label: 'Mehr', icon: Icon(Icons.more_horiz_outlined)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return ListingsScreen();
        } else {
          return SettingsPage();
        }
      },
    );
  }
}
