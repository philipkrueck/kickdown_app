import 'package:auto_route/auto_route_annotations.dart';
import 'package:kickdown_app/ui/views/navigation/navigation_view.dart';

@CupertinoAutoRouter(routes: <AutoRoute>[
  CupertinoRoute(page: NavigationView, initial: true, name: "InitialRoute"),
])
class $Router {}
