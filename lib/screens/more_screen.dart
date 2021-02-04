import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/components/buttons/button_03.dart';
import 'package:kickdown_app/styles.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();

  ChromeSafariBrowser browser = ChromeSafariBrowser();
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

class _MoreScreenState extends State<MoreScreen> {
  bool trackingIsOn = true;

  @override
  Widget build(BuildContext context) {
    List<SettingsListTileViewModel> settingsListTileViewModels = [
      SettingsListTileViewModel(
        title: 'Mein Account',
        trailing: Padding(
          padding: EdgeInsets.only(right: 16),
          child: Button03(
            text: 'Anmelden',
            onPressed: () {
              print('Anmelden');
            },
          ),
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
        trailing: Padding(
          padding: EdgeInsets.only(right: 10),
          child: CupertinoSwitch(
            value: trackingIsOn,
            activeColor: Styles.accentColor01Normal,
            onChanged: (bool newValue) {
              setState(() {
                trackingIsOn = newValue;
              });
            },
          ),
        ),
        isStartOfSection: true,
        isEndOfSection: true,
      )
    ];

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
    print('open $url');
    await widget.browser.open(
      url: url,
      options: ChromeSafariBrowserClassOptions(
        ios: IOSSafariOptions(
            transitionStyle: IOSUIModalTransitionStyle.PARTIAL_CURL),
      ),
    );
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
            height: isStartOfSection ? 28 : 0,
          ),
          isStartOfSection ? CupertinoSectionDivider() : Container(),
          Container(
            height: 44,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      title,
                      style: Styles.body01,
                    ),
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
    return Container(
      height: 1,
      color: Styles.settingsRowDivider, //Styles.settingsRowDivider,
    );
  }
}

class DetailIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        CupertinoIcons.forward,
        color: Styles.settingsDetailColor,
      ),
    );
  }
}
