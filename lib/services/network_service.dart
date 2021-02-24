import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:kickdown_app/models/posting.dart';

class NetworkService {
  static const _debugBaseURL = 'https://kdstaging.herokuapp.com/api/v1';
  static const _productionBaseURL = 'https://www.kickdown.com/api/v1';

  // NOTE: set up basic auth
  static String username = 'foo';
  static const String password = 'bar';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

  Future<List<Posting>> fetchPostings() async {
    final response = await http.get(
      '$_productionBaseURL/postings',
      headers: <String, String>{'authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return _parsePostings(response.body);
    } else {
      throw Exception('Failed to load listings');
    }
  }

  List<Posting> _parsePostings(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);

    List<dynamic> postings =
        parsed["postings"].map((json) => Posting.fromJson(json)).toList();
    return List<Posting>.from(postings);
  }

  Future<Image> loadImage({url, tryNumber = 0}) async {
    Image _image = Image.network(
      url,
      fit: BoxFit.cover,
    );

    Completer completer = new Completer<Image>();

    _image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool syncCall) {
          completer.complete(_image);
        },
      ),
    );

    return completer.future.timeout(
      // timeout after 10 seconds
      Duration(seconds: 20),
      onTimeout: () {
        Future.delayed(Duration(seconds: tryNumber * 10), () {
          loadImage(url: url);
        });
      },
    );
  }

  Future<List<String>> fetchImageUrls({String id}) async {
    final response = await http.get(
      '$_productionBaseURL/postings/$id/photos',
      headers: <String, String>{'authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      return _parseImageUrls(response.body);
    } else {
      throw Exception('Failed to load listings');
    }
  }

  List<String> _parseImageUrls(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);

    var photos = parsed['photos']
        .map((element) => element['data']['attributes']['photo_url'].toString())
        .toList();
    return List<String>.from(photos);
  }
}
