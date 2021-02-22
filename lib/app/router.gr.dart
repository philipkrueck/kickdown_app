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
import '../ui/views/posting_images_slider.dart/posting_images_slider_view.dart';
import '../ui/views/posting_images_slider.dart/posting_images_slider_viewmodel.dart';

class Routes {
  static const String InitialRoute = '/';
  static const String PostingDetailView = '/posting-detail-view';
  static const String PostingImagesSliderView = '/posting-images-slider-view';
  static const all = <String>{
    InitialRoute,
    PostingDetailView,
    PostingImagesSliderView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.InitialRoute, page: NavigationView),
    RouteDef(Routes.PostingDetailView, page: PostingDetailView),
    RouteDef(Routes.PostingImagesSliderView, page: PostingImagesSliderView),
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
    PostingImagesSliderView: (data) {
      final args =
          data.getArgs<PostingImagesSliderViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PostingImagesSliderView(
            postingImagesSliderViewmodel: args.postingImagesSliderViewmodel),
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

/// PostingImagesSliderView arguments holder class
class PostingImagesSliderViewArguments {
  final PostingImagesSliderViewmodel postingImagesSliderViewmodel;
  PostingImagesSliderViewArguments(
      {@required this.postingImagesSliderViewmodel});
}
