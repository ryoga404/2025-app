import 'package:flutter/cupertino.dart';
import 'package:mark_and_check/go_router/router.dart';

final routerConfig = RouterConfig(
  routeInformationParser: goRouter.routeInformationParser,
  routerDelegate: goRouter.routerDelegate,
  routeInformationProvider: goRouter.routeInformationProvider,
);
