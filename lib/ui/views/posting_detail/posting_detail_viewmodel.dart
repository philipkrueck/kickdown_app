import 'package:flutter/material.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/app/router.gr.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tuple/tuple.dart';

class PostingDetailViewmodel extends BaseViewModel {
  final PostingsManager _postingsManager = locator<PostingsManager>();
  final NavigationService _navigationService = locator<NavigationService>();
  final int postingIndex;
  Posting _posting;
  List<Tuple2<String, String>> _detailInformation;

  PostingDetailViewmodel({this.postingIndex}) {
    _posting = _postingsManager.getPosting(index: postingIndex);

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
  }

  Posting get posting => _posting;
  List<Tuple2<String, String>> get detailInformation => _detailInformation;

  String get description => _posting.description;

  void onBackButtonTapped({BuildContext context}) {
    // Note: Ideally this would be implemented via the navigation service
    // which isn't context sensitive
    Navigator.of(context).pop();
  }

  void onFavoriteTapped() {
    // TODO: implement favorite toggling on network
    _postingsManager.favoritePosting(index: postingIndex);
    notifyListeners();
  }

  void onPostingHeaderTapped() {
    _navigationService.navigateTo(Routes.PostingPhotosSliderView);
  }
}
