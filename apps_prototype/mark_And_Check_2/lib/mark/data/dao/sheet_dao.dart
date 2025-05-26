import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark_and_check/mark/data/app_database.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sheet.dart';

final sheetDaoDataSource = appDatabaseManagerProvider;

class SheetDao {
  late Database db;

  SheetDao(Ref ref) {
    db = ref.read(sheetDaoDataSource).db;
  }

  Future<void> insert(Sheet sheet) async {
    db.insert("sheets", {"name": sheet.name});
  }

  Future<List<Map<String, dynamic>>> getAll(Sheet sheet) async {
    return db.query("sheets");
  }
}
