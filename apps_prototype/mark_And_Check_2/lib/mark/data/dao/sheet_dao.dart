import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark_and_check/mark/data/app_database.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sheet.dart';

final sheetDaoDataSource = Provider((ref) => appDatabaseManagerProvider);

class SheetDao {
  late Database db;

  SheetDao(Ref ref) {
    db = ref.read(appDatabaseManagerProvider).db;
  }


  Future<void> insert(Sheet sheet) async {
    db.insert(sheet.name, sheet.toJson);
    }
}