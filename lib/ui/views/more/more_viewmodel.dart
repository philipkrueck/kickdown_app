import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@singleton
class MoreViewmodel extends BaseViewModel {
  static const String aboutKickdownURL =
      'https://www.kickdown.com/de/howitworks';
  static const String termsOfUsagesURL =
      'https://www.kickdown.com/de/auctions_terms';
  static const String privacyTermsURL = 'https://www.kickdown.com/de/privacy';
  static const String imprintURL = 'https://www.kickdown.com/de/imprint';

  ChromeSafariBrowser browser = ChromeSafariBrowser();
  bool _trackingIsOn = true; // This needs to be saved to system preferences

  bool get trackingIsOn => _trackingIsOn;

  void onTapLogin() {
    print('Login'); // TODO: implement navigate to login screen
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
