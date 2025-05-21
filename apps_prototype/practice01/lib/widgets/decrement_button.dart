import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';  // カウンタープロバイダー

class DecrementButton extends StatelessWidget {
  const DecrementButton({Key? key}) : super(key: key);  // const コンストラクタ

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CounterProvider>().decrement();  // デクリメント操作
      },
      backgroundColor: Colors.blue,
      child: const Icon(  // より標準的なアイコン
        Icons.remove,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
