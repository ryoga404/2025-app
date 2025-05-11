import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark_and_check/go_router/router.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(), //Riverpodでラップ　Wrapped by Riverpod.
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // アプリのRootウィジェット App root widget.
  @override
  Widget build(BuildContext context) {
    /*ウィジェットをビルドする*/
    return MaterialApp.router(
      //マテリアルAppでラップ
      //ナビゲーター
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      routeInformationProvider: goRouter.routeInformationProvider,
      //アプリ全体のデザイン
      title: 'Mark And Check',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple.shade400,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,


    );
  }
}
