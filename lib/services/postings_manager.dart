import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/network_service.dart';

// contains all logic regarding the management of postings
class PostingsManager {
  NetworkService _networkService = locator<NetworkService>();
  List<Posting> _postings;

  Future<List<Posting>> loadPostings() async {
    print('loading postings');
    _postings = await _networkService.fetchPostings();
    return _postings;
  }

  Posting getPosting({int index}) {
    assert(index < _postings.length);
    return _postings.elementAt(index);
  }

  void favorizePosting({int index}) {
    Posting posting = _postings[index];

    print(posting);
  }

  Future<void> fetchImageUrlsIfNeeded(Posting posting) async {
    if (posting.imageUrls == null) {
      print('fetching image urls...');
      List<String> imageUrls =
          await _networkService.fetchImageUrls(id: posting.id);
      posting.setImageUrls(imageUrls);
    }
  }
}
