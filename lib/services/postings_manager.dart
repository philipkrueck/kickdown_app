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
    loadHeroImages(_postings);
    return _postings;
  }

  Future<void> loadHeroImages(List<Posting> postings) async {
    for (int i = 0; i < postings.length; i++) {
      Image heroImage =
          await _networkService.loadImage(url: postings[i].heroPhotoURL);
      postings[i].addImage(heroImage, index: 0);
    }
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
    if (posting.loadingOrLoadedImagesLastIndex >= lastImageIndex ||
        _didLoadAllImages(posting)) return;

    print(
        'lastImageIndex = $lastImageIndex, lastLoadedIndex = ${posting.loadingOrLoadedImagesLastIndex}');

    int startIndex = posting.loadingOrLoadedImagesLastIndex + 1;
    int imageUrlsLastIndex = posting.imageUrls != null
        ? posting.imageUrls.length - 1
        : pow(2, 10); // set to a high number if not fetched yet
    lastImageIndex = min(lastImageIndex, imageUrlsLastIndex);
    posting.loadingOrLoadedImagesLastIndex = lastImageIndex;

    await _fetchImageUrlsIfNeeded(posting);

    print('fetching images $startIndex to $lastImageIndex...');

    // ToDo: start these operations in parallel
    for (int i = startIndex; i <= lastImageIndex; i++) {
      Image image = await _networkService.loadImage(url: posting.imageUrls[i]);
      if (image != null) {
        posting.addImage(image, index: i);
      }
    }

    print('fetching images $startIndex to $lastImageIndex completed.');
    return;
  }

  bool _didLoadAllImages(Posting posting) {
    return posting.imageUrls != null &&
        posting.imageUrls.length - 1 == posting.loadingOrLoadedImagesLastIndex;
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
