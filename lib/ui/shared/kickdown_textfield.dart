import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kickdown_app/styles.dart';

class KickdownTextField extends StatefulWidget {
  final bool isInvalid;
  final Function onInputTextChanged;

  const KickdownTextField({this.isInvalid = false, this.onInputTextChanged});

  @override
  _KickdownTextFieldState createState() => _KickdownTextFieldState();
}

class _KickdownTextFieldState extends State<KickdownTextField> {
  TextEditingController _textEditingController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onTextChanged);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onInputTextChanged(_textEditingController.text);
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _textEditingController,
      focusNode: _focusNode,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: (() {
          if (widget.isInvalid) {
            return Border.all(width: 2.0, color: Styles.kickdownRed);
          } else if (_focusNode.hasFocus) {
            return Border.all(width: 2.0, color: Styles.grayLight);
          }
          return Border.all(width: 1.0, color: Styles.grayLight);
        })(),
      ),
      cursorHeight: 12,
      cursorWidth: 2,
      placeholderStyle: Styles.textField02,
      style: Styles.textField01,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      placeholder: 'Ihr Gebot',
      cursorColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 16),
      onSubmitted: (String value) {
        print('submitted value $value');
      },
    );
  }
}
