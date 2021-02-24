import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class PostingHeaderViewmodel extends BaseViewModel {
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

  void onBackButtonTapped({BuildContext context}) {}
  int get currentIndex => null;
  int get totalImages => null;

  bool get shouldShowGallery => false;

  void setCurrentIndex(int index) {}

  CarouselController carouselController;
}
