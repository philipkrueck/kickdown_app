import 'package:flutter/cupertino.dart';

import '../styles.dart';

class NoActionInfoContainer extends StatelessWidget {
  final String text;

  NoActionInfoContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: Center(
        child: Text(
          'Es sind aktuell keine Daten vorhanden.',
          style: Styles.errorLabel,
        ),
      ),
    );
  }
}
