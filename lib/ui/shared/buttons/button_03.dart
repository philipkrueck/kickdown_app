import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/styles.dart';

class Button03 extends StatefulWidget {
  final String text;
  final Function onPressed;

  Button03({@required this.text, this.onPressed});

  @override
  _Button03State createState() => _Button03State();
}

class _Button03State extends State<Button03> {
  Color _textColor = Styles.accentColor01Normal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDetails) {
        setState(() {
          _textColor = Styles.accentColor01Pressed;
        });
      },
      onTapCancel: () {
        setState(() {
          _textColor = Styles.accentColor01Normal;
        });
      },
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => widget.onPressed(),
        pressedOpacity: 1,
        disabledColor: Styles.accentColor01Disabled,
        child: Text(
          widget.text,
          style: Styles.buttonText02.copyWith(color: _textColor),
        ),
      ),
    );
  }
}
