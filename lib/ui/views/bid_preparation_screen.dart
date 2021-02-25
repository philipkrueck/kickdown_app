import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/ui/shared/buttons/button_01.dart';
import 'package:kickdown_app/ui/shared/buttons/button_02.dart';
import 'package:kickdown_app/ui/shared/countdown_label.dart';

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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CountdownLabel(
                endDate: DateTime(2021, 2, 25, 21),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Aktuelles Gebot'),
              SizedBox(
                height: 10,
              ),
              Text('40.000€'),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 3, child: CupertinoTextField()),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Button01(
                        onPressed: _showErrorDialog,
                        text: 'Bieten',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            left: 0,
            top: 0,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                Icons.close,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () => print('close'),
            ),
          ),
        ],
      ),
    );
  }
}
