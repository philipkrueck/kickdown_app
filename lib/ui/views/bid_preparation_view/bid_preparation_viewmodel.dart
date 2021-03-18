import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:stacked/stacked.dart';

class BidPreparationViewmodel extends BaseViewModel {
  final Posting posting;
  final NumberFormat currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'eu', decimalDigits: 0);

  bool _textInputIsValid = true;
  bool get textInputIsValid => _textInputIsValid;

  String _bidAmount = "";

  BidPreparationViewmodel({@required this.posting});

  String get price => currencyFormatter.format(posting.currentPrice);

  DateTime get endDate => posting.endTime;

  void closeDialog({BuildContext context}) {
    print('close');
    Navigator.of(context).pop();
  }

  void onBidButtonPressed({BuildContext context}) {
    _textInputIsValid = _bidAmountIsValid;
    _showErrorDialog(context: context);
  }

  void onInputTextChanged(String newValue) {
    _bidAmount = newValue;
  }

  void _showErrorDialog({BuildContext context}) {
    notifyListeners();
    if (_bidAmountIsValid) {
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
  }

  bool get _bidAmountIsValid {
    if (_bidAmount == null) {
      return false;
    }
    return double.parse(_bidAmount, (e) => null) != null;
  }
}
