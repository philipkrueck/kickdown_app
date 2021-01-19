import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

  final ChromeSafariBrowser browser = ChromeSafariBrowser();
}

const String aboutKickdownURL = 'https://www.kickdown.com/de/howitworks';
const String termsOfUsagesURL = 'https://www.kickdown.com/de/auctions_terms';
const String privacyTermsUrl = 'https://www.kickdown.com/de/privacy';
const String imprintUrl = 'https://www.kickdown.com/de/imprint';
// const String forgotPasswordUrl = 'https://www.kickdown.com/users/password/new';

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Einstellungen'),
          ),
          child: Scaffold(
            body: ListView(
              children: [
                CupertinoListTile(
                  title: 'Mein Account',
                  trailing: CupertinoButton(
                    child: Text('Anmelden'),
                    onPressed: () => print('Anmelden'),
                  ),
                ),
                CupertinoListTile(
                  title: 'About Kickdown',
                  trailing: Icon(CupertinoIcons.forward),
                  onTap: () => _openUrl(aboutKickdownURL),
                ),
                CupertinoListTile(
                  title: 'AGB',
                  trailing: Icon(CupertinoIcons.forward),
                  onTap: () => _openUrl(termsOfUsagesURL),
                ),
                CupertinoListTile(
                  title: 'Datenschutz',
                  trailing: Icon(CupertinoIcons.forward),
                  onTap: () => _openUrl(privacyTermsUrl),
                ),
                CupertinoListTile(
                  title: 'Impressum',
                  trailing: Icon(CupertinoIcons.forward),
                  onTap: () => _openUrl(imprintUrl),
                ),
                CupertinoListTile(
                  title: 'Tracking',
                  trailing: CupertinoSwitch(
                    value: true,
                    activeColor: CupertinoTheme.of(context).primaryColor,
                    onChanged: (bool newValue) {
                      // update switch value
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openUrl(String url) async {
    await widget.browser.open(url: url);
  }
}

class CupertinoListTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final AsyncCallback onTap;

  CupertinoListTile({this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 1.0),
        ListTile(
          onTap: onTap,
          title: Text(title),
          trailing: trailing,
        ),
        Divider(thickness: 1.0)
      ],
    );
  }
}
