import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/go_router/my_router_config.dart';
import 'theme/app_theme.dart';

/// アプリケーションのルートウィジェット
class MarkAndCheckApp extends HookConsumerWidget {
  const MarkAndCheckApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp.router(
      // ルーターの設定を取得
      routerConfig: routerConfig,

      // アプリケーションの基本設定
      title: 'Mark And Check',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // デバッグバナーの設定
      debugShowCheckedModeBanner: true,
    );
  }
}
