import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/app/router.gr.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_detail_viewmodel.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';
import 'package:kickdown_app/ui/views/bid_preparation_view/bid_preparation_view.dart';
import 'package:kickdown_app/ui/views/bid_preparation_view/bid_preparation_viewmodel.dart';
import 'package:kickdown_app/ui/views/posting_images_slider.dart/posting_images_slider_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tuple/tuple.dart';

class PostingDetailViewmodel extends BaseViewModel {
  final PostingsManager _postingsManager = locator<PostingsManager>();
  final NavigationService _navigationService = locator<NavigationService>();
  final int postingIndex;
  PostingHeaderDetailViewmodel _postingHeaderViewmodel;
  Posting _posting;
  List<Tuple2<String, String>> _detailInformation;

  bool get imagesAreLoaded => posting.imageUrls != null;
  PostingHeaderViewmodel get postingHeaderViewmodel => _postingHeaderViewmodel;

  PostingDetailViewmodel({this.postingIndex}) {
    _posting = _postingsManager.getPosting(index: postingIndex);
    _postingHeaderViewmodel = PostingHeaderDetailViewmodel(posting: posting);

    _detailInformation = [
      Tuple2('Verkäufer', _posting.sellerName),
      Tuple2('Hersteller', _posting.carMake),
      Tuple2('Modell', _posting.carModel),
      Tuple2('Baujahr', '${_posting.carYear}'),
      Tuple2('Farbe', _posting.color),
      Tuple2('Kilometerstand', _posting.milage),
      Tuple2('Getriebe', _posting.transmission),
      Tuple2('Länderversion', _posting.country),
    ];

    _fetchImageUrlsIfNeeded();
  }

  @override
  dispose() {
    print('disposing');
    super.dispose();
  }

  Posting get posting => _posting;
  List<Tuple2<String, String>> get detailInformation => _detailInformation;

  String get description => _posting.description;

  void onFavoritePressed() {
    // TODO: implement favorite toggling on network
    _postingsManager.favorizePosting(index: postingIndex);
    notifyListeners();
  }

  void onPostingHeaderTapped() async {
    int currPageIndex = await _navigationService.navigateTo(
      Routes.PostingImagesSliderView,
      arguments: PostingImagesSliderViewArguments(
        postingImagesSliderViewmodel: PostingImagesSliderViewmodel(
            posting: posting,
            currentIndex: _postingHeaderViewmodel.currentIndex),
      ),
    );

    _postingHeaderViewmodel.setCurrentIndex(currPageIndex);
  }

  void onCTAButtonPressed({BuildContext context}) {
    showCupertinoModalPopup(
      context: context,
      semanticsDismissible: true,
      builder: (context) => BidPreparationView(
        viewmodel: BidPreparationViewmodel(
          posting: posting,
        ),
      ),
    );
  }

  void _fetchImageUrlsIfNeeded() async {
    await _postingsManager.fetchImageUrlsIfNeeded(posting);
    _postingHeaderViewmodel.setShouldShowGallery(true);

    notifyListeners();
  }
}
