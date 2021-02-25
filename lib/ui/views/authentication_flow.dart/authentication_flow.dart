import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/ui/shared/buttons/button_01.dart';
import 'package:kickdown_app/ui/views/authentication_flow.dart/authentication_flow_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AuthenticationFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationFlowViewmodel>.reactive(
      viewModelBuilder: () => AuthenticationFlowViewmodel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        child: Center(
          child: Button01(
            text: 'Login',
            onPressed: () {
              model.tapLogin();
            },
          ),
        ),
      ),
    );
  }
}
