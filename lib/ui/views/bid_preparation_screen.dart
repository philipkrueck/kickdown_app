import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/ui/shared/buttons/button_02.dart';

class BidPreparationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showErrorDialog() {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Aktion fehlgeschlagen'),
            content: Text('Sie müssen sich anmelden'),
            actions: [
              CupertinoDialogAction(
                child: Text('Ok'),
                isDefaultAction: true,
                isDestructiveAction: false,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Button02(
          onPressed: _showErrorDialog,
          text: 'Bieten',
        )
      ],
    );
  }
}
