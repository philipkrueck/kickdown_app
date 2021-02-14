import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kickdown_app/models/posting.dart';

class NetworkService {
  static const _debugBaseURL = 'https://kdstaging.herokuapp.com';
  static const _productionBaseURL = 'https://www.kickdown.com';

  Future<List<Posting>> fetchPostings() async {
    // NOTE: set up basic auth
    String username = 'foo';
    String password = 'bar';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.get(
      '$_productionBaseURL/api/v1/postings',
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
}
