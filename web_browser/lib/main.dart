import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer';

import 'router/router.dart' show router; // log関数を使用するためにインポート

void main() {
  log('main関数が開始されました。'); // main関数の開始ログ
  runApp(ProviderScope(child: MyApp()));
  log('runAppが呼び出されました。'); // runApp呼び出し後のログ
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    log('MyAppのbuildメソッドが呼び出されました。'); // buildメソッドの開始ログ
    //====
    //最初のページはrouter.dartの[initialLocation]プロパティで設定。
    //====
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,

      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
