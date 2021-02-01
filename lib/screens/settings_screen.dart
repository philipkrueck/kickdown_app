import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();

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
  bool isStartOfSection;
  bool isEndOfSection;

  SettingsListTileViewModel({
    @required this.title,
    this.trailing,
    this.url,
    this.isStartOfSection = false,
    this.isEndOfSection = false,
  });
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<SettingsListTileViewModel> settingsListTileViewModels = [
    SettingsListTileViewModel(
      title: 'Mein Account',
      trailing: CupertinoButton(
        padding: EdgeInsets.only(right: 8),
        child: Text('Anmelden'),
        onPressed: () => print('Anmelden'),
      ),
      isStartOfSection: true,
      isEndOfSection: true,
    ),
    SettingsListTileViewModel(
      title: 'About Kickdown',
      trailing: DetailIcon(),
      url: aboutKickdownURL,
      isStartOfSection: true,
    ),
    SettingsListTileViewModel(
      title: 'AGB',
      trailing: DetailIcon(),
      url: termsOfUsagesURL,
    ),
    SettingsListTileViewModel(
      title: 'Datenschutz',
      trailing: DetailIcon(),
      url: privacyTermsUrl,
    ),
    SettingsListTileViewModel(
      title: 'Impressum',
      trailing: DetailIcon(),
      url: imprintUrl,
      isEndOfSection: true,
    ),
    SettingsListTileViewModel(
      title: 'Tracking',
      trailing: CupertinoSwitch(
        value: true,
        onChanged: (bool newValue) {
          // update switch value
        },
      ),
      isStartOfSection: true,
      isEndOfSection: true,
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
      isStartOfSection: true,
      isEndOfSection: true,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(largeTitle: Text('Mehr')),
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
                  isStartOfSection: viewModel.isStartOfSection,
                  isEndOfSection: viewModel.isEndOfSection,
                );
              },
              childCount: settingsListTileViewModels.length,
            ),
          )
        ],
      ),
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
  final bool isStartOfSection;
  final bool isEndOfSection;

  CupertinoListTile(
      {@required this.title,
      this.trailing,
      this.onTap,
      @required this.isStartOfSection,
      @required this.isEndOfSection});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          SizedBox(
            height: isStartOfSection ? 20 : 0,
          ),
          isStartOfSection ? CupertinoSectionDivider() : Container(),
          Container(
            height: 44,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(title),
                  ),
                ),
                trailing,
              ],
            ),
          ),
          isEndOfSection
              ? CupertinoSectionDivider()
              : CupertinoInnerRowDivider(),
          SizedBox(
            height: isEndOfSection ? 20 : 0,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class CupertinoSectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Styles.settingsRowDivider,
    );
  }
}

class CupertinoInnerRowDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        height: 1,
        color: Styles.settingsRowDivider, //Styles.settingsRowDivider,
      ),
    );
  }
}

class DetailIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.forward,
      color: Styles.settingsDetailColor,
    );
  }
}
