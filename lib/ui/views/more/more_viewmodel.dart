import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/app/router.gr.dart';
import 'package:kickdown_app/services/network_service.dart';
import 'package:kickdown_app/ui/views/more/more_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class MoreViewmodel extends BaseViewModel {
  static const String aboutKickdownURL =
      'https://www.kickdown.com/de/howitworks';
  static const String termsOfUsagesURL =
      'https://www.kickdown.com/de/auctions_terms';
  static const String privacyTermsURL = 'https://www.kickdown.com/de/privacy';
  static const String imprintURL = 'https://www.kickdown.com/de/imprint';

  final NetworkService _networkService = locator<NetworkService>();
  final NavigationService _navigationService = locator<NavigationService>();
  ChromeSafariBrowser browser = ChromeSafariBrowser();
  bool _trackingIsOn = true; // This needs to be saved to system preferences
  StreamSubscription _isLoggedInSubscription;

  MoreViewModel() {
    _isLoggedInSubscription = _networkService.isLoggedInStream.listen(
      (newValue) {
        notifyListeners();
      },
    );
  }

  @override
  dispose() {
    _isLoggedInSubscription.cancel();
    super.dispose();
  }

  bool get trackingIsOn => _trackingIsOn;

  bool get userIsLoggedIn => _networkService.userIsLoggedIn;

  String get email => _networkService.email;

  void onTapLogin() {
    _navigationService.navigateTo(Routes.AuthenticationFlow);
  }

  void onTapLogout() {
    _networkService.logout();
  }

  Future<void> onTapAboutKickdownTile() {
    _openUrl(aboutKickdownURL);
  }

  Future<void> onTapTermsOfUsagesTile() {
    _openUrl(termsOfUsagesURL);
  }

  Future<void> onTapPrivacyTermsTile() {
    _openUrl(privacyTermsURL);
  }

  Future<void> onTapImprintTile() {
    _openUrl(imprintURL);
  }

  void setTracking({bool isOn}) {
    _trackingIsOn = isOn;
    notifyListeners();
  }

  // TODO: open web view modally
  Future<void> _openUrl(String url) async {
    print('open $url');
    await browser.open(
      url: url,
      options: ChromeSafariBrowserClassOptions(
        ios: IOSSafariOptions(
            transitionStyle: IOSUIModalTransitionStyle.PARTIAL_CURL),
      ),
    );
  }
}
