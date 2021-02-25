import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/utils/network/user_session_data.dart';

class NetworkService {
  static const _debugBaseURL = 'https://foo:bar@kdstaging.herokuapp.com/api/v1';
  static const _productionBaseURL = 'https://www.kickdown.com/api/v1';

  static const Map<String, String> _defaultHeaders = {
    "Content-Type": "application/json; charset=utf-8",
  };

  final StreamController _streamController = StreamController<bool>();

  static String baseURL = _productionBaseURL;

  UserSessionData userSessionData;

  bool get userIsLoggedIn =>
      userSessionData != null && userSessionData.uid != null;

  String get email => userSessionData.uid;

  Stream<bool> isLoggedInStream; // ToDo: create stream

  Map<String, String> get _httpHeaders {
    if (userSessionData != null &&
        userSessionData.httpHeaderValues.isNotEmpty) {
      var _newHeaders = Map.from(_defaultHeaders);
      print(
          'userSessionData.httpHeaderValues: ${userSessionData.httpHeaderValues}');

      _newHeaders..addAll(userSessionData.httpHeaderValues);
      return _newHeaders;
    }
    return _defaultHeaders;
  }

  @override
  void dispose() {
    _streamController.close();
  }

  Future<bool> login({String email, String password}) async {
    var queryParameters = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      '$baseURL/auth/sign_in',
      headers: _httpHeaders,
    );

    print(response.request.url);
    _initializeOrUpdateUserSessionDataWithHeaders(
        response.headers, response.statusCode);
    if (response.statusCode == 200) {
      print('successfully logged in');
      return true;
      // return _parsePostings(response.body);
    } else {
      print('could not login');
      throw Exception('Failed to login');
    }
  }

  Future<List<Posting>> fetchPostings() async {
    print('http headers: ${_httpHeaders}');

    final response = await http.get('$baseURL/postings', headers: _httpHeaders);

    print('response code: ${response.statusCode}');
    _initializeOrUpdateUserSessionDataWithHeaders(
        response.headers, response.statusCode);
    if (response.statusCode == 200) {
      print('successfully fetched postings');
      return _parsePostings(response.body);
    } else {
      throw Exception('Failed to load listings');
    }
  }

  Future<void> favorizePosting({String id}) async {
    final response = await http.get('$baseURL/postings/$id/star',
        headers: _defaultHeaders
          ..addAll(
              userSessionData != null ? userSessionData.httpHeaderValues : {}));

    _initializeOrUpdateUserSessionDataWithHeaders(
        response.headers, response.statusCode);
    if (response.statusCode != 200) {
      // ToDo: parse response and set bool value on posting, maybe not do it here
    } else {
      throw Exception("Could not favorize posting.");
    }
  }

  void logout() {
    userSessionData = null;
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
      Duration(seconds: 20 + 10 * tryNumber),
      onTimeout: () {
        Future.delayed(Duration(seconds: tryNumber * 10), () {
          loadImage(url: url);
        });
      },
    );
  }

  Future<List<String>> fetchImageUrls({String id}) async {
    final response = await http.get('$baseURL/postings/$id/photos',
        headers: _defaultHeaders
          ..addAll(
              userSessionData != null ? userSessionData.httpHeaderValues : {}));

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

  void _initializeOrUpdateUserSessionDataWithHeaders(
      Map<String, String> headers, int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      // success
      if (userSessionData == null) {
        userSessionData = UserSessionData.from(headers);
      } else {
        userSessionData.udpateWithHeaderFields(headers);
      }
    } else if (statusCode == 401) {
      // unauthorized
      logout();
    }
  }
}
