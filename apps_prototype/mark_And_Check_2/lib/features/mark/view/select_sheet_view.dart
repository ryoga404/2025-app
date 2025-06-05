import 'dart:developer' as debug;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/features/data/repository/local_repository.dart';
import 'package:mark_and_check/go_router/route_path_name.dart';

import '../../data/model/sheet.dart';

class SelectMarkSheetView extends ConsumerWidget {
  const SelectMarkSheetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalRepository repo = ref.read(localRepositoryProvider);
    AsyncValue<List<Sheet>> sheets = ref.watch(repo.getAllSheets());

    return Scaffold(
      appBar: AppBar(title: Text('Select Mark Sheet')),
      body: Center(
        child: sheets.when(
          data:
              (data) => ListView(children: data.map((e) => record(e)).toList()),
          error: (e, s) => throw Exception(),
          loading: () => CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RoutePathName.createMarkSheet),
        child:Icon(Icons.add),
      ),
    );
  }

  Widget record(Sheet sheet) {
    return Row(
      children: [
        Text(sheet.name),
        OutlinedButton(onPressed: () => debug.log("Edit pushed"), child: Text("Edit!")),
      ],
    );
  }
}
