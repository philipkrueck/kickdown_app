import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/services/network_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class PostingHeaderViewmodel extends BaseViewModel {
  final NetworkService _networkService = locator<NetworkService>();
  final DialogService _dialogService = locator<DialogService>();
  final NumberFormat currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'eu', decimalDigits: 0);

  Posting posting;
  bool get isDetail;

  List<Image> get images => posting.images;
  String get title => posting.title;
  String get city => posting.city;
  String get currentPrice => currencyFormatter.format(posting.currentPrice);
  bool get shouldShowFavorite => _networkService.userIsLoggedIn;
  DateTime get endDate => posting.endTime;
  bool get currentUserIsHighestBidder => false; // todo: implement
  String get id => posting.id;
  bool get starredByCurrentUser => posting.starredByCurrentUser ?? false;
  bool get shouldShowGallery => false;

  Function get onFavoriteTapped => () async {
        try {
          posting.toggleStarredByCurrentUser();
          bool newValue = await _networkService.favorizePosting(id: posting.id);
          posting.setStarredByCurrentUser(newValue: newValue);
        } catch (e) {
          _dialogService.showDialog(
            title: 'Auktion konnte nicht favorisiert werden',
            description: 'Bitte versuche es später erneut.',
          );
        }
      };

  void onBackButtonTapped({BuildContext context}) {}
  int get currentIndex => null;
  int get totalImages => null;

  void setCurrentIndex(int index) {}

  CarouselController carouselController;
}
