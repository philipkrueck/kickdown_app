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
  DateTime endTime = DateTime.utc(2021, 11, 9);
  List<String> _imageUrls;
  List<Image> _images = [null];
  List<String> get imageUrls => _imageUrls;
  List<Image> get images => _images;

  int loadingOrLoadedImagesLastIndex = -1;

  // Observable properties
  bool starredByCurrentUser;
  int currentPrice;
  bool loggedInUserIsHighestBidder;

  // TODO: add missing properties

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
      this.starredByCurrentUser,
      this.currentPrice,
      this.loggedInUserIsHighestBidder});

  // NOTE: this could possibly be generated using built_value and not mapped by hand
  factory Posting.fromJson(Map<String, dynamic> json) {
    final attributes = json["data"]["attributes"];
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
      currentPrice: attributes["current_price"],
      starredByCurrentUser: attributes["starred_by_current_user"],
    );
  }

  void addImage(Image image, {int index}) {
    _images[index] = image;
  }

  void setImages(List<Image> images) {
    _images = images;
  }

  void setImageUrls(List<String> imageUrls) {
    if (_imageUrls != null) return;
    _imageUrls = imageUrls;
    _images = List(_imageUrls.length);
    for (int i = 0; i < _images.length; i++) {
      _images[i] = null;
    }
  }
}
