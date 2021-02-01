import 'package:flutter/cupertino.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    placeholder = Image.asset(
      'assets/img_placeholder.png',
      fit: BoxFit.cover,
    );
  }

  static Image placeholder;
}
