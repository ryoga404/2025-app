import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/counter_provider.dart';  // カウンタープロバイダー
import 'widgets/counter_display.dart';    // カウンター表示ウィジェット
import 'widgets/increment_button.dart';   // インクリメントボタン
import 'widgets/decrement_button.dart';   // デクリメントボタン

void main() {
  runApp(
    // 状態管理用のProvider
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),  // CounterProviderを提供
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello, World!',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'serif',
              color: Colors.white,
              letterSpacing: 4,
            ),
          ),
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CounterDisplay(),  // カウンター表示ウィジェット
            ],
          ),
        ),
        floatingActionButton: Stack(
          clipBehavior: Clip.none,  // ボタンを重ねるためにClip.noneを使用
          children: [
            Positioned(
              left: 40,
              bottom: 20,
              child: DecrementButton(),  // デクリメントボタン
            ),
            Positioned(
              right: 15,
              bottom: 20,
              child: IncrementButton(),  // インクリメントボタン
            ),
          ],
        ),
      ),
    );
  }
}
