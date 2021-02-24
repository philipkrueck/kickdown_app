import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/ui/shared/buttons/button_01.dart';

class AuthenticationFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button01(
        text: 'Login',
        onPressed: () {
          print('login');
        },
      ),
    );
  }
}
