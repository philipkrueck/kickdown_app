import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/listings_page.dart';
import 'package:kickdown_app/settings_page.dart';

void main() {
  runApp(KickdownApp());
}

class KickdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hello',
      theme: CupertinoThemeData(primaryColor: Colors.red),
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
          return ListingsPage();
        } else {
          return SettingsPage();
        }
      },
    );
  }
}
