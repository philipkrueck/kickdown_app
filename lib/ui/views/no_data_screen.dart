import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/ui/shared/no_action_info_container.dart';

class NoDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoActionInfoContainer(
      text: 'Es sind aktuell keine Daten vorhanden.',
    );
  }
}
