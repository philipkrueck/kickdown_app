import 'package:flutter/cupertino.dart';

class ListingsPage extends StatefulWidget {
  @override
  _ListingsPageState createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Angebote'),
          ),
          child: Center(child: Text('Angebote')),
        );
      },
    );
  }
}
