import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kickdown_app/networking/posting.dart';

class NetworkLayer {
  static const _debugBaseURL = 'https://kdstaging.herokuapp.com';
  static const _productionBaseURL = 'https://www.kickdown.com';

  static Future<List<Posting>> fetchPostings() async {
    // NOTE: set up basic auth
    String username = 'foo';
    String password = 'bar';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.get(
      '$_debugBaseURL/api/v1/postings',
      headers: <String, String>{'authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return _parsePostings(response.body);
    } else {
      throw Exception('Failed to load listings');
    }
  }

  static List<Posting> _parsePostings(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);

    List<dynamic> postings =
        parsed["postings"].map((json) => Posting.fromJson(json)).toList();
    return List<Posting>.from(postings);
  }
}
