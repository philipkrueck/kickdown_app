import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/utils/network/user_session_data.dart';

class NetworkService {
  // static const _debugBaseURL = 'https://foo:bar@kdstaging.herokuapp.com/api/v1';
  static const _productionBaseURL = 'https://www.kickdown.com/api/v1';

  static const Map<String, String> _defaultHeaders = {
    "Content-Type": "application/json; charset=utf-8",
  };

  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();

  final httpClient = http.Client();

  static String baseURL = _productionBaseURL;

  UserSessionData userSessionData;

  bool get userIsLoggedIn => userSessionData != null && userSessionData.isValid;

  String get email => (userSessionData != null && userSessionData.uid != null)
      ? userSessionData.uid
      : null;

  Stream<bool> get isLoggedInStream =>
      _streamController.stream.asBroadcastStream();

  Map<String, String> get _httpHeaders {
    if (userSessionData != null &&
        userSessionData.httpHeaderValues.isNotEmpty) {
      Map<String, String> _newHeaders = Map.from(_defaultHeaders);
      print(
          'userSessionData.httpHeaderValues: ${userSessionData.httpHeaderValues}');

      _newHeaders..addAll(userSessionData.httpHeaderValues);
      return _newHeaders;
    }
    return _defaultHeaders;
  }

  void dispose() {
    _streamController.close();
  }

  Future<bool> login({String email, String password}) async {
    var queryParameters = {
      'email': email,
      'password': password,
    };

    String queryString = Uri(queryParameters: queryParameters).query;

    final response = await httpClient.post(
      '$baseURL/auth/sign_in?' + queryString,
      headers: _httpHeaders,
    );

    print(response.request.url);
    _initializeOrUpdateUserSessionDataWithHeaders(response.headers,
        statusCode: response.statusCode);
    if (response.statusCode == 200) {
      _streamController.add(true);
      print('successfully logged in');
      return true;
      // return _parsePostings(response.body);
    } else {
      print('could not login');
      throw Exception('Failed to login');
    }
  }

  Future<List<Posting>> fetchPostings() async {
    final response =
        await httpClient.get('$baseURL/postings', headers: _httpHeaders);
    _initializeOrUpdateUserSessionDataWithHeaders(response.headers,
        statusCode: response.statusCode);
    if (response.statusCode == 200) {
      return _parsePostings(response.body);
    } else {
      print('Failed to load postings');
      throw Exception('Failed to load listings');
    }
  }

  Future<bool> favorizePosting({String id}) async {
    final response = await httpClient.post('$baseURL/postings/$id/star',
        headers: _httpHeaders);

    print(id);

    _initializeOrUpdateUserSessionDataWithHeaders(response.headers,
        statusCode: response.statusCode);
    if (response.statusCode == 200) {
      print('favorized!!!');
      Map<String, dynamic> parsed =
          jsonDecode(response.body) as Map<String, dynamic>;
      print(parsed);
      bool isFavorite = parsed['active'] as bool;
      return isFavorite;
    } else {
      throw Exception("Could not favorize posting.");
    }
  }

  void logout() {
    print('logout');
    userSessionData = null;
    _streamController.sink.add(false);
  }

  List<Posting> _parsePostings(String responseBody) {
    Map<String, dynamic> parsed =
        jsonDecode(responseBody) as Map<String, dynamic>;

    List<dynamic> postings = parsed["postings"]
        .map((json) => Posting.fromJson(json as Map<String, dynamic>))
        .toList() as List<dynamic>;
    return List<Posting>.from(postings);
  }

  Future<List<String>> fetchImageUrls({String id}) async {
    final response = await httpClient.get('$baseURL/postings/$id/photos',
        headers: _httpHeaders);

    _initializeOrUpdateUserSessionDataWithHeaders(response.headers,
        statusCode: response.statusCode);
    if (response.statusCode == 200) {
      return _parseImageUrls(response.body);
    } else {
      print('failed to load image urls');
      throw Exception('Failed to load image urls');
    }
  }

  List<String> _parseImageUrls(String responseBody) {
    Map<String, dynamic> parsed =
        jsonDecode(responseBody) as Map<String, dynamic>;

    List<dynamic> photos = parsed['photos']
        .map((element) => element['data']['attributes']['photo_url'].toString())
        .toList() as List;
    return List<String>.from(photos);
  }

  void _initializeOrUpdateUserSessionDataWithHeaders(
      Map<String, String> headers,
      {int statusCode}) {
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
