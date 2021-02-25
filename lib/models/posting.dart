import 'dart:async';

import 'package:flutter/widgets.dart';

class Posting {
  // TODO: make properties get only
  String id;
  String sellerName;
  String description;
  String carMake;
  int carYear;
  String carModel;
  String country;
  String city;
  String title;
  String package;
  String milage;
  String color;
  String transmission;
  String heroPhotoURL;
  String auctionCode;
  int highestBidInEuro;
  DateTime endTime;
  List<String> _imageUrls;
  List<Image> _images = [null];
  List<String> get imageUrls => _imageUrls;
  List<Image> get images => _images;

  int loadingOrLoadedImagesLastIndex = -1;

  // Observable properties
  bool starredByCurrentUser;
  int currentPrice;
  bool loggedInUserIsHighestBidder;

  final StreamController<int> _imageAddedStreamController =
      StreamController<int>.broadcast();
  final StreamController<bool> _starredStreamController =
      StreamController<bool>.broadcast();

  Stream<int> get imageAddedAtIndexStream =>
      _imageAddedStreamController.stream.asBroadcastStream();

  Stream<bool> get starredByCurrentUserStream =>
      _starredStreamController.stream.asBroadcastStream();

  Posting(
      {this.id,
      this.sellerName,
      this.description,
      this.carMake,
      this.carYear,
      this.carModel,
      this.country,
      this.city,
      this.title,
      this.package,
      this.milage,
      this.color,
      this.transmission,
      this.heroPhotoURL,
      this.auctionCode,
      this.highestBidInEuro,
      this.endTime,
      this.starredByCurrentUser,
      this.currentPrice,
      this.loggedInUserIsHighestBidder});

  // NOTE: this could possibly be generated using built_value and not mapped by hand
  factory Posting.fromJson(Map<String, dynamic> json) {
    final attributes = json["data"]["attributes"];

    print('starredByCurrentUser: ${attributes["starred_by_current_user"]}');

    return Posting(
      id: json["data"]["id"],
      sellerName: attributes["seller_name"],
      description: attributes["seller_description"],
      carMake: attributes["car_make"],
      carYear: attributes["car_year"],
      carModel: attributes["car_model"],
      country: attributes["country"],
      city: attributes["city"],
      title: attributes["title"],
      package: attributes["package"],
      milage: attributes["milage"],
      color: attributes["colour"],
      transmission: attributes["transmission"],
      heroPhotoURL: attributes["hero_photo_url"],
      auctionCode: attributes["auction_code"],
      highestBidInEuro: attributes["highest_bid_amount_in_euro"],
      endTime: DateTime.parse(json["included"][0]["attributes"]["end_at"]),
      currentPrice: attributes["current_price"],
      starredByCurrentUser: attributes["starred_by_current_user"],
    );
  }

  void dispose() {
    _imageAddedStreamController.close();
    _starredStreamController.close();
  }

  void addImage(Image image, {int index}) {
    _images[index] = image;
    _imageAddedStreamController.sink.add(index);
    print('index $index added to stream controller');
  }

  void setImageUrls(List<String> imageUrls) {
    if (_imageUrls != null) return;
    _imageUrls = imageUrls;
    Image firstImage = _images[0];
    _images = List(_imageUrls.length);
    _images[0] = firstImage;
    for (int i = 1; i < _images.length; i++) {
      _images[i] = null;
    }
  }

  void toggleStarredByCurrentUser() {
    if (starredByCurrentUser == null) return;
    starredByCurrentUser = !starredByCurrentUser;
    _starredStreamController.sink.add(starredByCurrentUser);
  }

  void setStarredByCurrentUser({bool newValue}) {
    starredByCurrentUser = newValue;
    _starredStreamController.sink.add(starredByCurrentUser);
  }
}
