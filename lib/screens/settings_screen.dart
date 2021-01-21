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

class SettingsListTileViewModel {
  String title;
  Widget trailing;
  String url;

  SettingsListTileViewModel({@required this.title, this.trailing, this.url});
}

class _SettingsPageState extends State<SettingsPage> {
  List<SettingsListTileViewModel> settingsListTileViewModels = [
    SettingsListTileViewModel(
      title: 'Mein Account',
      trailing: CupertinoButton(
        child: Text('Anmelden'),
        onPressed: () => print('Anmelden'),
      ),
    ),
    SettingsListTileViewModel(
      title: 'About Kickdown',
      trailing: Icon(CupertinoIcons.forward),
      url: aboutKickdownURL,
    ),
    SettingsListTileViewModel(
      title: 'AGB',
      trailing: Icon(CupertinoIcons.forward),
      url: termsOfUsagesURL,
    ),
    SettingsListTileViewModel(
      title: 'Datenschutz',
      trailing: Icon(CupertinoIcons.forward),
      url: privacyTermsUrl,
    ),
    SettingsListTileViewModel(
      title: 'Impressum',
      trailing: Icon(CupertinoIcons.forward),
      url: imprintUrl,
    ),
    SettingsListTileViewModel(
      title: 'Tracking',
      trailing: CupertinoSwitch(
        value: true,
        onChanged: (bool newValue) {
          // update switch value
        },
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    settingsListTileViewModels.last = SettingsListTileViewModel(
      title: 'Tracking',
      trailing: CupertinoSwitch(
        activeColor: CupertinoTheme.of(context).primaryColor,
        value: true,
        onChanged: (bool newValue) {
          // update switch value
        },
      ),
    );

    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(largeTitle: Text('Einstellungen')),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final viewModel = settingsListTileViewModels[index];
                      return CupertinoListTile(
                        title: viewModel.title,
                        trailing: viewModel.trailing,
                        onTap: viewModel.url != null
                            ? () => _openUrl(viewModel.url)
                            : null,
                      );
                    },
                    childCount: settingsListTileViewModels.length,
                  ),
                )
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
