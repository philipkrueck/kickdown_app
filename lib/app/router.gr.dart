// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../models/posting.dart';
import '../ui/views/navigation/navigation_view.dart';
import '../ui/views/posting_detail_screen.dart';

class Routes {
  static const String InitialRoute = '/';
  static const String PostingDetailView = '/posting-details-screen';
  static const all = <String>{
    InitialRoute,
    PostingDetailView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.InitialRoute, page: NavigationView),
    RouteDef(Routes.PostingDetailView, page: PostingDetailsScreen),
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
    PostingDetailsScreen: (data) {
      final args = data.getArgs<PostingDetailsScreenArguments>(
        orElse: () => PostingDetailsScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PostingDetailsScreen(posting: args.posting),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PostingDetailsScreen arguments holder class
class PostingDetailsScreenArguments {
  final Posting posting;
  PostingDetailsScreenArguments({this.posting});
}
