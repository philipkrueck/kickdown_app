import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/app/router.gr.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_overview_viewmodel.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';
import 'package:kickdown_app/ui/views/posting_detail/posting_detail_view.dart';
import 'package:kickdown_app/ui/views/posting_detail/posting_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_services/stacked_services.dart';

enum LoadingState {
  loading,
  data,
  noData,
  error,
}

@singleton
class PostingsViewmodel extends BaseViewModel {
  PostingsManager _postingsManager = locator<PostingsManager>();
  NavigationService _navigationService = locator<NavigationService>();
  LoadingState _loadingState = LoadingState.loading;
  List<Posting> _postings;
  List<PostingHeaderViewmodel> _postingHeaderViewModels;

  LoadingState get loadingState => _loadingState;

  int get postingCardCount => _postingHeaderViewModels.length;

  void initialize() {
    _fetchPostings();
  }

  void refreshPostings() async {
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
      _postingHeaderViewModels = _postings
          .map((posting) => PostingHeaderOverviewViewmodel(posting))
          .toList();
    } catch (e) {
      _loadingState = LoadingState.error;
    }
    notifyListeners();
  }

  PostingHeaderViewmodel headerViewmodel({int index}) {
    return _postingHeaderViewModels[index];
  }

  void handleTapOnItem({@required int index, @required context}) {
    if (index >= _postings.length) return;

    PostingDetailViewmodel postingDetailViewmodel =
        PostingDetailViewmodel(postingIndex: index);

    // NOTE: ideally the navigation service would have been used here,
    // but it is not context aware
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => PostingDetailView(
          postingDetailViewmodel: postingDetailViewmodel,
        ),
      ),
    );
  }
}
