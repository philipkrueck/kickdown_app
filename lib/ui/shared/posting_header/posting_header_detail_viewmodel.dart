import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:intl/intl.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';
import 'package:kickdown_app/utils/image_gallery_index_manager.dart';

class PostingHeaderDetailViewmodel extends PostingHeaderViewmodel {
  final PostingsManager _postingsManager = locator<PostingsManager>();
  final Posting posting;
  final ImageGalleryIndexManager imageGalleryIndexManager;
  final NumberFormat currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'eu', decimalDigits: 0);
  StreamSubscription<int> _imageAdddedListener;
  StreamSubscription<bool> _currentIndexChangedListener;

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
  }

  @override
  void dispose() {
    _imageAdddedListener.cancel();
    _currentIndexChangedListener.cancel();
    super.dispose();
  }

  CarouselController carouselController = CarouselController();

  String get city => posting.city;

  String get currentPrice => currencyFormatter.format(posting.currentPrice);

  bool get currentUserIsHighestBidder => false; // ToDo: implement

  DateTime get endDate => posting.endTime;

  String get id => posting.id;

  List<Image> get images => posting.images;

  bool get isDetail => true;

  Function get onFavoriteTapped => () {
        // ToDo: implement
        print('favorite');
        print(images[0]);
      };

  @override
  void onBackButtonTapped({BuildContext context}) {
    // Ideally this would be implemented using the NavigationService,
    // but it isn't yet context sensitive
    Navigator.of(context).pop();
  }

  bool get starredByCurrentUser => false; // ToDo: implement

  bool get showImageGallery => true;

  String get title => posting.title;

  bool get shouldShowFavorite =>
      true; // TODO: should be based on authentication

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
