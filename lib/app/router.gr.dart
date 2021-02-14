// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../ui/views/navigation/navigation_view.dart';

class Routes {
  static const String InitialRoute = '/';
  static const all = <String>{
    InitialRoute,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.InitialRoute, page: NavigationView),
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
  };
}
