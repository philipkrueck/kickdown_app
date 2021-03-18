import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/services/network_service.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@singleton
class MoreViewmodel extends BaseViewModel {
  static const String aboutKickdownURL =
      'https://www.kickdown.com/de/howitworks';
  static const String termsOfUsagesURL =
      'https://www.kickdown.com/de/auctions_terms';
  static const String privacyTermsURL = 'https://www.kickdown.com/de/privacy';
  static const String imprintURL = 'https://www.kickdown.com/de/imprint';

  final NetworkService _networkService = locator<NetworkService>();
  final ChromeSafariBrowser browser = ChromeSafariBrowser();
  final ChromeSafariBrowserClassOptions browserOptions =
      ChromeSafariBrowserClassOptions(
    ios: IOSSafariOptions(
      dismissButtonStyle: IOSSafariDismissButtonStyle.CLOSE,
      presentationStyle: IOSUIModalPresentationStyle.OVER_FULL_SCREEN,
    ),
  );
  bool _trackingIsOn = true; // This needs to be saved to system preferences
  StreamSubscription _isLoggedInSubscription;

  void initialize() {
    _isLoggedInSubscription = _networkService.isLoggedInStream.listen(
      (_) {
        print('MoreViewmodel. isLoggedInStream changed');
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
    // temporarily disabled for testing
    // _navigationService.navigateTo(Routes.AuthenticationFlow);
  }

  void onTapLogout() {
    _networkService.logout();
  }

  void onTapAboutKickdownTile() async {
    await _openUrl(aboutKickdownURL);
  }

  void onTapTermsOfUsagesTile() async {
    await _openUrl(termsOfUsagesURL);
  }

  void onTapPrivacyTermsTile() async {
    await _openUrl(privacyTermsURL);
  }

  void onTapImprintTile() async {
    await _openUrl(imprintURL);
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
      options: browserOptions,
    );
  }
}
