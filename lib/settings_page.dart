import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Einstellungen'),
          ),
          child: Center(child: Text('Einstellungen')),
        );
      },
    );
    ;
  }
}
