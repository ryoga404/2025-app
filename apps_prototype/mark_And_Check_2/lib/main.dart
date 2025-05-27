import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/app.dart';

// アプリケーションのエントリーポイント
void main() {
  
  // アプリケーションを起動
  runApp(
    // Riverpodのプロバイダースコープでアプリをラップ
    const ProviderScope(
      child: MarkAndCheckApp(),
    ),
  );
}

