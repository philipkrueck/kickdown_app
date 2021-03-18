import 'package:flutter/widgets.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostingImagesSliderViewmodel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  int currentIndex;

  PageController _pageController;

  PageController get pageController => _pageController;

  int get totalImages => posting.imageUrls.length;

  List<String> get imageUrls => posting.imageUrls;

  final Posting posting;

  PostingImagesSliderViewmodel(
      {@required this.posting, this.currentIndex = 0}) {
    _pageController = PageController(initialPage: currentIndex);

    _pageController.addListener(() {
      int newIndex = _pageController.page.round();
      if (currentIndex != newIndex) {
        currentIndex = newIndex;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void tapCloseButton() {
    _navigationService.back(result: currentIndex);
  }
}
