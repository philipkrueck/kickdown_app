import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/ui/views/more/more_view.dart';
import 'package:kickdown_app/ui/views/navigation/navigation_viewmodel.dart';
import 'package:kickdown_app/ui/views/postings/postings_view.dart';
import 'package:stacked/stacked.dart';

class NavigationView extends StatelessWidget {
  final overviewNormalTabIcon =
      TabBarIcon(path: 'assets/ic_menu_overview_normal.png');
  final overviewSelectedTabIcon =
      TabBarIcon(path: 'assets/ic_menu_overview_selected.png');
  final moreNormalTabIcon = TabBarIcon(path: 'assets/ic_menu_more_normal.png');
  final moreSelectedTabIcon =
      TabBarIcon(path: 'assets/ic_menu_more_selected.png');

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationViewmodel>.reactive(
      viewModelBuilder: () => locator<NavigationViewmodel>(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              label: 'Angebote',
              icon: overviewNormalTabIcon,
              activeIcon: overviewSelectedTabIcon,
            ),
            BottomNavigationBarItem(
              label: 'Mehr',
              icon: moreNormalTabIcon,
              activeIcon: moreSelectedTabIcon,
            ),
          ],
        ),
        tabBuilder: getViewForIndex,
      ),
    );
  }

  Widget getViewForIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        return PostingsView();
      case 1:
        return MoreView();
      default:
        return PostingsView();
    }
  }
}

class TabBarIcon extends StatelessWidget {
  final String path;
  TabBarIcon({this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      // TODO: apply style as an icon
      path,
      width: 24,
      height: 24,
      color: IconTheme.of(context).color,
    );
  }
}
