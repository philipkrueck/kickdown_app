import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';

class Button02 extends StatefulWidget {
  final String text;
  final Function onPressed;

  Button02({@required this.text, this.onPressed});

  @override
  _Button02State createState() => _Button02State();
}

class _Button02State extends State<Button02> {
  Color _outlineColor = Styles.accentColor01Normal;
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDetails) {
        setState(() {
          _backgroundColor = Styles.accentColor01Pressed.withOpacity(0.15);
          _outlineColor = Styles.accentColor01Pressed;
        });
      },
      onTapCancel: () {
        setState(() {
          _backgroundColor = Colors.white;
          _outlineColor = Styles.accentColor01Normal;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _outlineColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => widget.onPressed(),
          color: _backgroundColor,
          pressedOpacity: 1,
          disabledColor: Styles.accentColor01Disabled,
          child: Text(
            widget.text,
            style: Styles.buttonText02,
          ),
        ),
      ),
    );
  }
}
