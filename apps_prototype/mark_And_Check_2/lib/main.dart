import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/app.dart';
import 'features/data/app_database.dart';

// アプリケーションのエントリーポイント
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // アプリケーションを起動
  runApp(
    // Riverpodのプロバイダースコープでアプリをラップ
    const ProviderScope(child: MarkAndCheckApp()),
  );
}
