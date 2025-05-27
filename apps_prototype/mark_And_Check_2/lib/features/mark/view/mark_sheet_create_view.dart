import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarkSheetCreateView extends StatelessWidget {
  const MarkSheetCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Mark Sheet')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Sheet Name',
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  // TODO: シート名を入力してシートを作成する処理
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('シート作成機能は開発中です')),
                  );
                },
                child: const Text('Create!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
