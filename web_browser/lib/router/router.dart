import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:web_browser/home_page.dart';
import 'package:web_browser/tree_view/treeview.dart';

import '../node/node.dart';

part 'router.g.dart';

final router = GoRouter(initialLocation: '/', routes: $appRoutes);

@TypedGoRoute<HomeRoute>(
  path: "/",
  routes: [
    TypedGoRoute<TreeViewRoute>(path: "/tree"),
    TypedGoRoute<BrowserViewRoute>(path: "/browser",routes: [TypedGoRoute<TreeViewRoute>(path: "/tree")]),
  ]
)

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MyHomePage();
}

class TreeViewRoute extends GoRouteData with $TreeViewRoute {
  const TreeViewRoute({required this.$extra});

  final Node $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TreeView(rootNode: $extra);
}

class BrowserViewRoute extends GoRouteData with $BrowserViewRoute {
  const BrowserViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => InAppWebView();
}
