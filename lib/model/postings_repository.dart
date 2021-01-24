import 'package:kickdown_app/networking/network_layer.dart';
import 'package:kickdown_app/networking/posting.dart';

abstract class PostingsRepository {
  static Future<List<Posting>> loadPostings() {
    return NetworkLayer.fetchPostings();
  }
}
