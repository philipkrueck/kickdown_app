import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class GlobalImageCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'globalCachedImageData';

  static GlobalImageCacheManager _instance;
  factory GlobalImageCacheManager() {
    _instance ??= GlobalImageCacheManager._();
    return _instance;
  }

  GlobalImageCacheManager._() : super(Config(key));
}
