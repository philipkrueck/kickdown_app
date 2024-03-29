import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/styles.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/router.gr.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Styles.kickdownRed,
        barBackgroundColor: Colors.white,
      ),
    );
  }
}
