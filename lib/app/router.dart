import 'package:auto_route/auto_route_annotations.dart';
import 'package:kickdown_app/ui/views/navigation/navigation_view.dart';
import 'package:kickdown_app/ui/views/posting_detail_screen.dart';

@CupertinoAutoRouter(routes: <AutoRoute>[
  CupertinoRoute(page: NavigationView, initial: true, name: "InitialRoute"),
  CupertinoRoute(
      page: PostingDetailsScreen, initial: false, name: "PostingDetailView"),
])
class $Router {}
