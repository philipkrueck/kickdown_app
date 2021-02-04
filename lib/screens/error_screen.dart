import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/components/no_action_info_container.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoActionInfoContainer(
      text:
          'Es ist ein Fehler aufgetreten. Bitte überprüfen Sie Ihre Internetverbindung und versuchen es erneut.',
    );
  }
}
