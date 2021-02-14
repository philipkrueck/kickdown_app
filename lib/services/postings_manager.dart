import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/network_service.dart';

// contains all logic regarding the fetching of postings
class PostingsManager {
  NetworkService _networkService = locator<NetworkService>();

  Future<List<Posting>> loadPostings() {
    return _networkService.fetchPostings();
  }
}
