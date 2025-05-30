import 'dart:async';
import 'package:flutter/material.dart';
import 'calculation.dart'; // 計算ロジックを分離

void main() => runApp(MyApp());

final StreamController<String> controller = StreamController<String>.broadcast();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DisplayText(),
            Keyboard(),
          ],
        ),
      ),
    );
  }
}

//==============================================================================
// 表示部（電卓の画面表示）
class DisplayText extends StatefulWidget {
  @override
  _DisplayTextState createState() => _DisplayTextState();
}

class _DisplayTextState extends State<DisplayText> {
  String _expression = '';

  @override
  void initState() {
    super.initState();
    controller.stream.listen((letter) {
      setState(() {
        if (letter == 'C') {
          _expression = '';
          Calculator.GetKey(letter); // 状態クリア
        } else if (letter == '=') {
          String result = Calculator.Execute();
          if (result == 'e') {
            _expression = 'Error';
          } else {
            _expression = result;
          }
        } else {
          _expression += letter;
          Calculator.GetKey(letter); // 数字や演算子入力
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.black12,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            _expression,
            style: TextStyle(fontSize: 64.0),
          ),
        ),
      ),
    );
  }
}

//==============================================================================
// キーボード（ボタンのグリッド）
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Container(
          color: const Color(0xff87cefa),
          child: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            children: [
              '7', '8', '9', '÷',
              '4', '5', '6', '×',
              '1', '2', '3', '-',
              'C', '0', '=', '+',
            ].map((key) {
              return GridTile(
                child: Button(key),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

//==============================================================================
// 各ボタン
class Button extends StatelessWidget {
  final String _key;
  Button(this._key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          controller.sink.add(_key);
        },
        child: Center(
          child: Text(
            _key,
            style: TextStyle(
              fontSize: 46.0,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
