import 'dart:developer' as debug;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/features/data/model/sheet.dart';
import 'package:mark_and_check/features/data/repository/local_repository.dart';

class MarkSheetCreateView extends HookConsumerWidget {
  const MarkSheetCreateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sheetName = useState('');
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
                onChanged: (str) => sheetName.value = str,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  debug.log("${sheetName.value} inserting");
                  ref
                      .read(localRepositoryProvider)
                      .insertSheets(Sheet(null, sheetName.value));
                  showDialog(context: context,
                      builder: (context) {
                    return AlertDialog(
                      title: Text("Created!"),
                      content: Text("作成完了"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
                      ]
                    );
                      }
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
