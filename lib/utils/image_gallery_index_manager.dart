import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';

class ImageGalleryIndexManager {
  final PostingsManager _postingsManager = locator<PostingsManager>();

  final int postingIndex;

  int _currentIndex = 0;
  Posting _posting;

  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();

  Stream<bool> get currentIndexChangedStream =>
      _streamController.stream.asBroadcastStream();

  ImageGalleryIndexManager({@required this.postingIndex}) {
    _posting = _postingsManager.getPosting(index: postingIndex);
  }

  void dispose() {
    _streamController.close();
  }

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    assert(index < _posting.images.length);
    _currentIndex = index;
    if (_currentIndex >= _posting.loadingOrLoadedImagesLastIndex - 5) {
      _postingsManager.fetchImagesForPosting(
          postingIndex: postingIndex,
          lastImageIndex: _posting.loadingOrLoadedImagesLastIndex + 5);
    }
    _streamController.add(true);
  }
}
