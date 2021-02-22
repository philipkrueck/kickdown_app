import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';

class PostingHeaderOverviewViewmodel implements PostingHeaderViewmodel {
  final NumberFormat currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'eu', decimalDigits: 0);
  final PostingsManager _postingsManager = locator<PostingsManager>();
  final Posting posting;

  PostingHeaderOverviewViewmodel(this.posting);

  List<Image> get images => posting.images;

  String get title => posting.title;

  String get city => posting.city;

  String get priceInEuro => '${posting.currentPrice}€';

  bool get shouldShowFavorite =>
      true; // TODO: should be based on authentication

  DateTime get endDate => posting.endTime;

  bool get currentUserIsHighestBidder => false;

  String get currentPrice => currencyFormatter.format(posting.currentPrice);

  String get id => posting.id;

  Function get onBackButtonTapped => null;

  Function get onFavoriteTapped => () {
        // ToDo: implement
        print('favorite');
      };

  bool get starredByCurrentUser => false; // ToDo: implement

  bool get showImageGallery => false;

  bool get isDetail => false;
}
