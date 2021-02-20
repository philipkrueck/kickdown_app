import 'package:flutter/widgets.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostingPhotosSliderViewmodel extends BaseViewModel {
  PostingsManager _postingsManager = locator<PostingsManager>();
  NavigationService _navigationService = locator<NavigationService>();

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  int get totalImages => _posting.imageUrls.length;

  final int postingIndex;
  Posting _posting;

  PostingPhotosSliderViewmodel({@required this.postingIndex}) {
    _posting = _postingsManager.getPosting(index: postingIndex);
  }

  List<Image> get images => _posting.images;

  Image image({int index}) {
    if (index >= _posting.images.length) return null;
    return _posting.images[index];
  }

  void tapCloseButton() {
    _navigationService.back();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    print(_posting.loadingOrLoadedImagesLastIndex);
    if (_currentIndex >= _posting.loadingOrLoadedImagesLastIndex - 5) {
      print('calling fetchImages');
      _postingsManager.fetchImagesForPosting(
          postingIndex: postingIndex,
          lastImageIndex: _posting.loadingOrLoadedImagesLastIndex + 5);
    }

    notifyListeners();
  }
}
