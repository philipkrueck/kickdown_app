import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: CupertinoActivityIndicator(
        radius: 16,
      ),
    );
  }
}
