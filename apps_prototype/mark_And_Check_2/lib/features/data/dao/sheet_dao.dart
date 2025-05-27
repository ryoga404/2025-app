import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark_and_check/features/data/app_database.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sheet.dart';

final sheetDaoDataSource = appDatabaseManagerProvider;
final sheetDaoProvider = Provider((ref) => SheetDao(ref));

class SheetDao {
  late final Database db;

  SheetDao(Ref ref) {
    db = ref.read(sheetDaoDataSource).db;
  }

  insert(Sheet sheet) {
    db.insert("sheets", {"name": sheet.name});
  }


  Future<List<Sheet>> searchById(int id) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      'sheets',
      where: 'id = ?',
      whereArgs: [id],
    );

    List<Sheet> sheets = rawData.map((e) => Sheet.fromJson(e)).toList();
    return sheets;
  }

  Future<List<Sheet>> getAll() async {
    final List<Map<String, dynamic>> rawData = await db.query('sheets');
    return rawData.map((e) => Sheet.fromJson(e)).toList();
  }

}
