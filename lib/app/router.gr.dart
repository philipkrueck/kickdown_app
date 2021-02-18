// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../ui/views/navigation/navigation_view.dart';
import '../ui/views/posting_detail/posting_detail_view.dart';
import '../ui/views/posting_detail/posting_detail_viewmodel.dart';
import '../ui/views/posting_detail/posting_photos_slider_view.dart';

class Routes {
  static const String InitialRoute = '/';
  static const String PostingDetailView = '/posting-detail-view';
  static const String PostingPhotosSliderView = '/posting-photos-slider-view';
  static const all = <String>{
    InitialRoute,
    PostingDetailView,
    PostingPhotosSliderView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.InitialRoute, page: NavigationView),
    RouteDef(Routes.PostingDetailView, page: PostingDetailView),
    RouteDef(Routes.PostingPhotosSliderView, page: PostingPhotosSliderView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    NavigationView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => NavigationView(),
        settings: data,
      );
    },
    PostingDetailView: (data) {
      final args = data.getArgs<PostingDetailViewArguments>(
        orElse: () => PostingDetailViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PostingDetailView(
            postingDetailViewmodel: args.postingDetailViewmodel),
        settings: data,
      );
    },
    PostingPhotosSliderView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PostingPhotosSliderView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PostingDetailView arguments holder class
class PostingDetailViewArguments {
  final PostingDetailViewmodel postingDetailViewmodel;
  PostingDetailViewArguments({this.postingDetailViewmodel});
}
