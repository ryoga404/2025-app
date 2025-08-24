import 'package:flutter/material.dart';
import 'package:web_browser/browser_view.dart';
import 'package:web_browser/home_page.dart';
import 'dart:developer'; // log関数を使用するためにインポート

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
    final bool toBrowser = true; // ここでtoBrowserを設定
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: toBrowser
          ? InAppWebviewSample() // toBrowserに応じて表示するウィジェットを切り替え
          : const MyHomePage(title: 'aa',), // HomePageを表示
    );
  }
}

