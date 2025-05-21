import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';  // カウンタープロバイダー

class IncrementButton extends StatelessWidget {
  const IncrementButton({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CounterProvider>().increment();  // デクリメント操作
      },
      backgroundColor: Colors.blue,
      child: const Icon(  // より標準的なアイコン
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

