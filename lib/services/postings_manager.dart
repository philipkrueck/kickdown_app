import 'dart:collection';

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
    if (index >= _postings.length) return null;
    return _postings.elementAt(index);
  }

  void favoritePosting({int index}) {
    // ToDo: implement
    print('favorite');
  }
}
