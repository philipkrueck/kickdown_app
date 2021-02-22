import 'package:flutter/material.dart';

abstract class PostingHeaderViewmodel {
  bool get showImageGallery;
  bool get isDetail;

  List<Image> get images;
  String get title;
  String get city;
  String get currentPrice;
  bool get shouldShowFavorite;
  DateTime get endDate;
  bool get currentUserIsHighestBidder;
  String get id;
  bool get starredByCurrentUser;
  Function get onFavoriteTapped;

  Function get onBackButtonTapped;
}
