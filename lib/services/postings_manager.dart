import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/network_service.dart';

// contains all logic regarding the management of postings
class PostingsManager {
  NetworkService _networkService = locator<NetworkService>();
  List<Posting> _postings;

  Future<List<Posting>> loadPostings() async {
    _postings = await _networkService.fetchPostings();
    return _postings;
  }

  Posting getPosting({int index}) {
    assert(index < _postings.length);
    return _postings.elementAt(index);
  }

  void favoritePosting({int index}) {
    // ToDo: implement
    print('favorite');
  }

  Future<void> fetchImagesForPosting(
      {int postingIndex, int lastImageIndex = 2}) async {
    assert(postingIndex < _postings.length);
    Posting posting = _postings[postingIndex];

    if (posting.loadingOrLoadedImagesLastIndex >= lastImageIndex) return;

    int startIndex = posting.loadingOrLoadedImagesLastIndex + 1;
    posting.loadingOrLoadedImagesLastIndex = min(lastImageIndex,
        posting.images != null ? posting.images.length : pow(2, 52));

    await _fetchImageUrlsIfNeeded(posting);

    if (lastImageIndex >= posting.imageUrls.length) return;

    int lastIndex = min(lastImageIndex, posting.imageUrls.length - 1);

    print('fetching images $startIndex to $lastIndex...');

    for (int i = startIndex; i <= lastIndex; i++) {
      Image image = await _networkService.loadImage(url: posting.imageUrls[i]);
      if (image != null) {
        posting.addImage(image, index: i);
      }
    }

    print('fetching images $startIndex to $lastIndex completed.');
    return;
  }

  Future<void> _fetchImageUrlsIfNeeded(Posting posting) async {
    if (posting.imageUrls == null) {
      print('fetching image urls...');
      List<String> imageUrls =
          await _networkService.fetchImageUrls(id: posting.id);
      posting.setImageUrls(imageUrls);
    }
  }
}
