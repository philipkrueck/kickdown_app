// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../utils/global_image_cache_manager.dart';
import '../ui/views/more/more_viewmodel.dart';
import '../ui/views/navigation/navigation_viewmodel.dart';
import '../services/network_service.dart';
import '../services/postings_manager.dart';
import '../ui/views/postings/postings_viewmodel.dart';
import '../services/third_party_services_module.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule(get);
  gh.lazySingleton<CacheManager>(() => thirdPartyServicesModule.cacheManager);
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.factory<GlobalImageCacheManager>(() => GlobalImageCacheManager());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<NetworkService>(
      () => thirdPartyServicesModule.networkService);
  gh.lazySingleton<PostingsManager>(
      () => thirdPartyServicesModule.postingsService);

  // Eager singletons must be registered in the right order
  gh.singleton<MoreViewmodel>(MoreViewmodel());
  gh.singleton<NavigationViewmodel>(NavigationViewmodel());
  gh.singleton<PostingsViewmodel>(PostingsViewmodel());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  final GetIt _get;
  _$ThirdPartyServicesModule(this._get);
  @override
  CacheManager get cacheManager => CacheManager(_get<Config>());
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  NetworkService get networkService => NetworkService();
  @override
  PostingsManager get postingsService => PostingsManager();
}
