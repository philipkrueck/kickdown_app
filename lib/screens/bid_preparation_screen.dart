import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/components/bid_button.dart';

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
      children: [
        BidButton(
          onButtonPressed: _showErrorDialog,
        )
      ],
    );
  }
}
