import 'dart:async';

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
  List<String> get imageUrls => _imageUrls;

  int loadingOrLoadedImagesLastIndex = -1;

  // Observable properties
  bool starredByCurrentUser;
  int currentPrice;
  bool loggedInUserIsHighestBidder;

  final StreamController<bool> _starredStreamController =
      StreamController<bool>.broadcast();

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
      id: json["data"]["id"] as String,
      sellerName: attributes["seller_name"] as String,
      description: attributes["seller_description"] as String,
      carMake: attributes["car_make"] as String,
      carYear: attributes["car_year"] as int,
      carModel: attributes["car_model"] as String,
      country: attributes["country"] as String,
      city: attributes["city"] as String,
      title: attributes["title"] as String,
      package: attributes["package"] as String,
      milage: attributes["milage"] as String,
      color: attributes["colour"] as String,
      transmission: attributes["transmission"] as String,
      heroPhotoURL: attributes["hero_photo_url"] as String,
      auctionCode: attributes["auction_code"] as String,
      highestBidInEuro: attributes["highest_bid_amount_in_euro"] as int,
      endTime:
          DateTime.parse(json["included"][0]["attributes"]["end_at"] as String),
      currentPrice: attributes["current_price"] as int,
      starredByCurrentUser: attributes["starred_by_current_user"] as bool,
    );
  }

  void dispose() {
    _starredStreamController.close();
  }

  void setImageUrls(List<String> imageUrls) {
    if (_imageUrls != null) return;
    _imageUrls = imageUrls;
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
