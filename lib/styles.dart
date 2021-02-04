import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const TextStyle productRowItemName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const Color settingsRowDivider = Color(0xFFD9D9D9);

  static const Color settingsDetailColor = Color(0xFFD9D9D9);

  // STYLE GUIDE STARTS HERE:

  // COLORS
  static const Color _kickdownRed = Color(0xFFF44336);
  static const Color _kickdownDarkRed = Color(0xFFC62B20);
  static const Color _black = Color(0xFF000000);
  static const Color _grayDark = Color(0xFF848484);
  static const Color _grayLight = Color(0xFFC7C7C7);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _green = Color(0xFF6CD971);
  static final Color _gradientBlack =
      Color.lerp(_black.withOpacity(0), _black, 0.5);

  static const Color textColor02 = _grayLight;
  static const Color accentColor01Normal = _kickdownRed;
  static const Color accentColor01Pressed = _kickdownDarkRed;
  static const Color annotationBadgeColor = _green;

  // TEXT STYLES
  static const TextStyle title01 =
      TextStyle(color: _black, fontSize: 25, fontWeight: FontWeight.w800);

  static const TextStyle title02 =
      TextStyle(color: _black, fontSize: 15, fontWeight: FontWeight.w800);

  static const TextStyle title03 =
      TextStyle(color: _kickdownRed, fontSize: 25, fontWeight: FontWeight.w800);

  static const TextStyle title04 =
      TextStyle(color: _white, fontSize: 15, fontWeight: FontWeight.w800);

  static const TextStyle body01 =
      TextStyle(color: _black, fontSize: 15, fontWeight: FontWeight.normal);

  static const TextStyle caption01 =
      TextStyle(color: _grayDark, fontSize: 13, fontWeight: FontWeight.normal);

  static const TextStyle caption02 =
      TextStyle(color: _grayDark, fontSize: 13, fontWeight: FontWeight.bold);

  static const TextStyle caption03 =
      TextStyle(color: _kickdownRed, fontSize: 13, fontWeight: FontWeight.bold);

  static const TextStyle caption04 =
      TextStyle(color: _white, fontSize: 13, fontWeight: FontWeight.bold);

  static const TextStyle caption05 = TextStyle(
      color: _kickdownRed, fontSize: 13, fontWeight: FontWeight.normal);

  static final TextStyle errorLabel = body01.copyWith(color: textColor02);

  static const TextStyle buttonText01 = TextStyle(
    color: _white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static final TextStyle buttonText02 =
      buttonText01.copyWith(color: accentColor01Normal);
}
