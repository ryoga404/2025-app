import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mark_and_check/features/mark/view/select_sheet_view.dart';
import 'package:mark_and_check/go_router/route_path_name.dart';
import 'package:mark_and_check/features/mark/view/mark_mode_select_view.dart';
import 'package:mark_and_check/features/mark/view/mark_sheet_create_view.dart';

import '../features/home/presentation/pages/home_page.dart';

final goRouter = GoRouter(
  // when starting the application
  initialLocation: RoutePathName.home,
  //path and view combo
 routes: [
    GoRoute(
      path: RoutePathName.home,
      name: 'initial',
      pageBuilder: (context, state) {
        return MaterialPage(key: state.pageKey, child: const HomePage());
      },
    ),
    //Mark画面
    GoRoute(
      path: RoutePathName.markModeSelect,
      name: 'mark_mode_select',
      pageBuilder: (context, state) {
        return MaterialPage(key: state.pageKey, child: const MarkModeSelectView());
      },
    ),
    GoRoute(
      path: RoutePathName.createMarkSheet,
      name: "create_mark_sheet",
      pageBuilder: (context, state) {
        return MaterialPage(key: state.pageKey, child: const MarkSheetCreateView());
      },
    ),
   GoRoute(
       path: RoutePathName.selectMarkSheet,
       name: "select_mark_sheet",
       pageBuilder: (context, state) {
         return MaterialPage(key: state.pageKey, child: const SelectMarkSheetView());
       },
   )
  ],

  errorPageBuilder:
      (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(body: Center(child: Text(state.error.toString()))),
      ),
);

