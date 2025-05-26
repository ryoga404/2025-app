import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/app.dart';
import 'package:mark_and_check/go_router/router.dart';

// アプリケーションのエントリーポイント
void main() {
  // Flutterのバインディングを初期化
  WidgetsFlutterBinding.ensureInitialized();
  
  // アプリケーションを起動
  runApp(
    // Riverpodのプロバイダースコープでアプリをラップ
    const ProviderScope(
      child: MarkAndCheckApp(),
    ),
  );
}

