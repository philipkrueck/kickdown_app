import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';
import 'package:kickdown_app/utils/image_gallery_index_manager.dart';

class PostingHeaderDetailViewmodel extends PostingHeaderViewmodel {
  final ImageGalleryIndexManager imageGalleryIndexManager;
  Posting posting;
  StreamSubscription<int> _imageAdddedListener;
  StreamSubscription<bool> _currentIndexChangedListener;
  StreamSubscription<bool> _starredByUserListener;

  bool _shouldShowGallery = false;

  PostingHeaderDetailViewmodel(
      {@required this.posting, @required this.imageGalleryIndexManager}) {
    _imageAdddedListener = posting.imageAddedAtIndexStream.listen((index) {
      if (index == currentIndex) return;
      notifyListeners();
    });

    _currentIndexChangedListener =
        imageGalleryIndexManager.currentIndexChangedStream.listen((_) {
      print('new index is ${imageGalleryIndexManager.currentIndex}');
      notifyListeners();
      Future.delayed(
          Duration(seconds: 1),
          () => {
                carouselController.animateToPage(
                    imageGalleryIndexManager.currentIndex,
                    duration: Duration(milliseconds: 300))
              });
    });

    _starredByUserListener = posting.starredByCurrentUserStream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _imageAdddedListener.cancel();
    _currentIndexChangedListener.cancel();
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

  bool get shouldShowGallery => _shouldShowGallery;

  @override
  int get currentIndex => imageGalleryIndexManager.currentIndex;

  @override
  int get totalImages => posting.images.length;

  void setShouldShowGallery(bool newValue) {
    _shouldShowGallery = newValue;
    notifyListeners();
  }

  @override
  void setCurrentIndex(int index) {
    assert(index < images.length);
    imageGalleryIndexManager.setCurrentIndex(index);
  }
}
