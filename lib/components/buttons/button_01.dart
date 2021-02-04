import 'package:flutter/cupertino.dart';

import '../../styles.dart';

class Button01 extends StatefulWidget {
  final String text;
  final Function onPressed;

  Button01({@required this.text, this.onPressed});

  @override
  _Button01State createState() => _Button01State();
}

class _Button01State extends State<Button01> {
  Color _backgroundColor = Styles.accentColor01Normal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDetails) {
        setState(() {
          _backgroundColor = Styles.accentColor01Pressed;
        });
      },
      onTapCancel: () {
        setState(() {
          _backgroundColor = Styles.accentColor01Normal;
        });
      },
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: widget.onPressed,
        color: _backgroundColor,
        pressedOpacity: 1,
        disabledColor: Styles.accentColor01Disabled,
        child: Text(
          widget.text,
          style: Styles.buttonText01,
        ),
      ),
    );
  }
}
