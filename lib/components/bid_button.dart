import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BidButton extends StatelessWidget {
  final Function onButtonPressed;
  BidButton({this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text('Bieten'),
      color: Colors.red,
      onPressed: onButtonPressed,
    );
  }
}
