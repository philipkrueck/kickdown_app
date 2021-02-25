import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/services/network_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationFlowViewmodel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  NetworkService _networkService = locator<NetworkService>();

  void tapLogin() async {
    try {
      await _networkService.login(
        email: 'maybachmusic@kickdown.xx',
        password: 'maybach',
      );
      _navigationService.back();
    } catch (e) {
      print('Show Failure UI');
    }
  }
}
