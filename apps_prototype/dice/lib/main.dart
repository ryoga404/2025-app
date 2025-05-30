import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: Text(
            "サイコロ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'serif',
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.cyan,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  // 行・列の定義
  final int rows = 20;
  final int columns = 5;

  // サイコロの状態をリストで管理
  late List<int> diceValues;

  @override
  void initState() {
    super.initState();
    diceValues = List.generate(rows * columns, (_) => 1);
  }

  // サイコロを全て振る
  void rollDice() {
    setState(() {
      diceValues = List.generate(rows * columns, (_) => Random().nextInt(6) + 1);
    });
  }

  // サイコロのウィジェットを生成
  Widget buildDice(int diceNumber) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: MaterialButton(
          onPressed: rollDice,
          child: Image.asset("assets/images/dice$diceNumber.png"),
        ),
      ),
    );
  }

  // 1行分のRowウィジェットを生成
  Widget buildDiceRow(int rowIndex) {
    return Row(
      children: List.generate(columns, (colIndex) {
        int index = rowIndex * columns + colIndex;
        return buildDice(diceValues[index]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(rows, (rowIndex) => buildDiceRow(rowIndex)),
      ),
    );
  }
}
