import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/buttons/button_03.dart';
import 'package:kickdown_app/ui/views/more/more_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreViewmodel>.reactive(
      viewModelBuilder: () => locator<MoreViewmodel>(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => CupertinoTabView(
        builder: (context) => CupertinoPageScaffold(
          backgroundColor: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              const CupertinoSliverNavigationBar(
                largeTitle: Text(
                  'Mehr',
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        return CupertinoListTile(
                          title: model.userIsLoggedIn && model.email != null
                              ? model.email
                              : 'Mein Account',
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: model.userIsLoggedIn
                                ? Button03(
                                    text: 'Abmelden',
                                    onPressed: () {
                                      model.onTapLogout();
                                    },
                                  )
                                : Button03(
                                    text: 'Anmelden',
                                    onPressed: () {
                                      model.onTapLogin();
                                    },
                                  ),
                          ),
                          onTap: null,
                          isStartOfSection: true,
                          isEndOfSection: true,
                        );
                      case 1:
                        return CupertinoListTile(
                          title: 'About Kickdown',
                          trailing: DetailIcon(),
                          onTap: () async => model.onTapAboutKickdownTile(),
                          isStartOfSection: true,
                          isEndOfSection: false,
                        );
                      case 2:
                        return CupertinoListTile(
                          title: 'AGB',
                          trailing: DetailIcon(),
                          onTap: () async => model.onTapTermsOfUsagesTile(),
                          isStartOfSection: false,
                          isEndOfSection: false,
                        );
                      case 3:
                        return CupertinoListTile(
                          title: 'Datenschutz',
                          trailing: DetailIcon(),
                          onTap: () async => model.onTapPrivacyTermsTile(),
                          isStartOfSection: false,
                          isEndOfSection: false,
                        );
                      case 4:
                        return CupertinoListTile(
                          title: 'Impressum',
                          trailing: DetailIcon(),
                          onTap: () async => model.onTapImprintTile(),
                          isStartOfSection: false,
                          isEndOfSection: true,
                        );
                      case 5:
                        return CupertinoListTile(
                          title: 'Tracking',
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CupertinoSwitch(
                              value: model.trackingIsOn,
                              activeColor: Styles.accentColor01Normal,
                              onChanged: (bool newValue) {
                                model.setTracking(isOn: newValue);
                              },
                            ),
                          ),
                          onTap: null,
                          isStartOfSection: true,
                          isEndOfSection: true,
                        );
                      default:
                        return null;
                    }
                  },
                  childCount: 6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CupertinoListTile extends StatefulWidget {
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
  _CupertinoListTileState createState() => _CupertinoListTileState();
}

class _CupertinoListTileState extends State<CupertinoListTile> {
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.isStartOfSection ? 30 : 0,
        ),
        widget.isStartOfSection
            ? CupertinoSectionDivider(
                isStartOfSection: widget.isStartOfSection,
              )
            : Container(),
        GestureDetector(
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              height: 50,
              color: _backgroundColor,
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Styles.body01,
                  ),
                  widget.trailing,
                ],
              ),
            ),
          ),
          onTapDown: (tapDetails) {
            if (widget.onTap == null) {
              return;
            }
            setState(() {
              _backgroundColor = CupertinoColors.secondarySystemFill;
            });
          },
          onTapCancel: () {
            if (widget.onTap == null) {
              return;
            }
            setState(() {
              _backgroundColor = Colors.white;
            });
          },
        ),
        widget.isEndOfSection
            ? const CupertinoSectionDivider(
                isStartOfSection: false,
              )
            : CupertinoInnerRowDivider(),
        SizedBox(
          height: widget.isEndOfSection ? 20 : 0,
        ),
      ],
    );
  }
}

class CupertinoSectionDivider extends StatelessWidget {
  final bool isStartOfSection;

  const CupertinoSectionDivider({this.isStartOfSection});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isStartOfSection ? 1 : 0.5,
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
        height: 0.5,
        color: Styles.settingsRowDivider,
      ),
    );
  }
}

class DetailIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.forward,
      color: Styles.chevronColor,
    );
  }
}
