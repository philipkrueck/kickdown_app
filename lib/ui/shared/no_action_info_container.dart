import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/styles.dart';

class NoActionInfoContainer extends StatelessWidget {
  final String text;

  NoActionInfoContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Styles.errorLabel,
          ),
        ),
      ),
    );
  }
}
