import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mark_and_check/go_router/route_path_name.dart';

class AppRouter{
  static void toHome(BuildContext context)=>
      context.push(RoutePathName.home);

  static void toMarkModeSelect(BuildContext context)=>
      context.push(RoutePathName.markModeSelect);

  static void toCreateMarkSheet(BuildContext context)=>
      context.push(RoutePathName.createMarkSheet);
}