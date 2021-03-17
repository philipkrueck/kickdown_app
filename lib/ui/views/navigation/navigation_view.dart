import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/ui/views/more/more_view.dart';
import 'package:kickdown_app/ui/views/navigation/navigation_viewmodel.dart';
import 'package:kickdown_app/ui/views/postings/postings_view.dart';
import 'package:stacked/stacked.dart';

class NavigationView extends StatelessWidget {
  final overviewImageNormal = Image.asset('assets/ic_menu_overview_normal.png');
  final overviewImageSelected =
      Image.asset('assets/ic_menu_overview_selected.png');
  final moreImageNormal = Image.asset('assets/ic_menu_more_normal.png');
  final moreImageSelected = Image.asset('assets/ic_menu_more_selected.png');

  void preCacheTabBarImages(BuildContext context) {
    [
      overviewImageNormal,
      overviewImageSelected,
      moreImageNormal,
      moreImageSelected
    ].forEach(
      (image) => precacheImage(
        image.image,
        context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationViewmodel>.reactive(
      viewModelBuilder: () => locator<NavigationViewmodel>(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (_) => preCacheTabBarImages(context),
      builder: (context, model, child) => CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              label: 'Angebote',
              icon: TabBarIcon(
                image: overviewImageNormal.image,
              ),
              activeIcon: TabBarIcon(
                image: overviewImageSelected.image,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Mehr',
              icon: TabBarIcon(
                image: moreImageNormal.image,
              ),
              activeIcon: TabBarIcon(
                image: moreImageSelected.image,
              ),
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
  ImageProvider image;
  TabBarIcon({this.image});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      width: 24,
      height: 24,
      color: IconTheme.of(context).color,
    );
  }
}
