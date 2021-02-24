import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/utils/image_gallery_index_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostingImagesSliderViewmodel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageGalleryIndexManager imageGalleryIndexManager;
  StreamSubscription<int> _imageAdddedListener;
  StreamSubscription<bool> _currentIndexChangedListener;

  int get currentIndex => imageGalleryIndexManager.currentIndex;

  int get totalImages => posting.imageUrls.length;

  final Posting posting;

  PostingImagesSliderViewmodel(
      {@required this.posting, @required this.imageGalleryIndexManager}) {
    _imageAdddedListener = posting.imageAddedAtIndexStream.listen((index) {
      if (index == currentIndex) return;
      notifyListeners();
    });

    _currentIndexChangedListener =
        imageGalleryIndexManager.currentIndexChangedStream.listen((_) {
      print('new index is ${imageGalleryIndexManager.currentIndex}');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _imageAdddedListener.cancel();
    _currentIndexChangedListener.cancel();
    super.dispose();
  }

  List<Image> get images => posting.images;

  Image image({int index}) {
    if (index >= posting.images.length) return null;
    return posting.images[index];
  }

  void tapCloseButton() {
    _navigationService.back();
  }

  void setCurrentIndex(int index) {
    assert(index < images.length);
    imageGalleryIndexManager.setCurrentIndex(index);
  }
}
