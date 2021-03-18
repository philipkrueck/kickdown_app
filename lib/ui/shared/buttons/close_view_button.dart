import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloseViewButton extends StatelessWidget {
  final Color color;
  final Function onPressed;

  const CloseViewButton({this.color = Colors.white, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(0.0),
      child: Image.asset(
        "assets/ic_navbar_close.png",
        color: color,
        height: 30,
      ),
      onPressed: () => onPressed(),
    );
  }
}
