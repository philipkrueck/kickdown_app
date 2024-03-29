import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/network_service.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_overview_viewmodel.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';
import 'package:kickdown_app/ui/views/posting_detail/posting_detail_view.dart';
import 'package:kickdown_app/ui/views/posting_detail/posting_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/widgets.dart';

enum LoadingState {
  loading,
  data,
  noData,
  error,
}

@singleton
class PostingsViewmodel extends BaseViewModel {
  PostingsManager _postingsManager = locator<PostingsManager>();
  NetworkService _networkService = locator<NetworkService>();
  LoadingState _loadingState = LoadingState.loading;
  List<Posting> _postings;
  List<PostingHeaderViewmodel> _postingHeaderViewModels;
  StreamSubscription<bool> _userIsLoggedInListener;

  LoadingState get loadingState => _loadingState;

  int get postingCardCount => _postingHeaderViewModels.length;

  void initialize() {
    _userIsLoggedInListener = _networkService.isLoggedInStream.listen((_) {
      print('PostingsViewmodel: userLoggedInStream changed');
      _fetchPostings();
    });

    _fetchPostings();
  }

  @override
  void dispose() {
    _userIsLoggedInListener.cancel();
    super.dispose();
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
      print(e.toString());
      _loadingState = LoadingState.error;
    }
    notifyListeners();
  }

  PostingHeaderViewmodel headerViewmodel({int index}) {
    return _postingHeaderViewModels[index];
  }

  void handleTapOnItem({@required int index, @required BuildContext context}) {
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
