import 'package:flutter/material.dart';
import 'package:web_browser/home_page.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:developer'; // log関数を使用するためにインポート
import 'browser_view.dart';

void main() {
  log('main関数が開始されました。'); // main関数の開始ログ
  runApp(const MyApp());
  log('runAppが呼び出されました。'); // runApp呼び出し後のログ
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log('MyAppのbuildメソッドが呼び出されました。'); // buildメソッドの開始ログ
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    home: InAppWebviewSample()
    );
  }
}

