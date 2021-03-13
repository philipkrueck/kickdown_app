import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';
import 'package:kickdown_app/utils/image_gallery_index_manager.dart';

class PostingHeaderDetailViewmodel extends PostingHeaderViewmodel {
  final ImageGalleryIndexManager imageGalleryIndexManager;
  Posting posting;
  PageController _pageController = PageController();
  StreamSubscription<bool> _starredByUserListener;

  int _currentIndex = 0;

  PostingHeaderDetailViewmodel(
      {@required this.posting, @required this.imageGalleryIndexManager}) {
    _starredByUserListener = posting.starredByCurrentUserStream.listen((_) {
      notifyListeners();
    });

    _pageController.addListener(() {
      int newIndex = _pageController.page.round();
      if (_currentIndex != newIndex) {
        _currentIndex = newIndex;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _starredByUserListener.cancel();
    super.dispose();
  }

  CarouselController carouselController = CarouselController();

  bool get isDetail => true;

  @override
  void onBackButtonTapped({BuildContext context}) {
    // Ideally this would be implemented using the NavigationService,
    // but it isn't yet context sensitive
    Navigator.of(context).pop();
  }

  bool get shouldShowGallery => posting.imageUrls != null;

  @override
  PageController get pageController => _pageController;

  @override
  int get currentIndex => _currentIndex;

  @override
  int get totalImages => posting.images.length;

  // ToDo: should rather listen to a postings stream than letting this property be set from the outside
  void setShouldShowGallery(bool newValue) {
    notifyListeners();
  }
}
