import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:kickdown_app/services/network_service.dart';
import 'package:kickdown_app/services/postings_manager.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  PostingsManager get postingsService;

  @lazySingleton
  NetworkService get networkService;

  @lazySingleton
  CacheManager get cacheManager;
}
