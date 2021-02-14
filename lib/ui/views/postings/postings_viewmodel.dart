import 'package:injectable/injectable.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:stacked/stacked.dart';

enum LoadingState {
  loading,
  data,
  noData,
  error,
}

@singleton
class PostingsViewmodel extends BaseViewModel {
  PostingsManager _postingsManager = locator<PostingsManager>();
  LoadingState _loadingState = LoadingState.loading;
  List<Posting> _postings;

  LoadingState get loadingState => _loadingState;
  List<Posting> get postings => _postings;

  void initialize() {
    _fetchPostings();
  }

  void refreshPostings() {
    _fetchPostings();
  }

  void _fetchPostings() async {
    try {
      List<Posting> fetchedPostings = await _postingsManager.loadPostings();
      if (fetchedPostings.isEmpty) {
        _loadingState = LoadingState.noData;
      } else {
        _loadingState = LoadingState.data;
      }
      _postings = fetchedPostings;
    } catch (e) {
      _loadingState = LoadingState.error;
    }
    notifyListeners();
  }
}
