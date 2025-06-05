import 'dart:developer' as debug;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/features/data/app_database.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sheet.dart';

final sheetDaoProvider = Provider((ref) => SheetDao(ref));

class SheetDao {
  final Future<Database> _db;

  factory SheetDao(Ref ref) =>
      SheetDao._(AppDatabaseManager().getDatabase());

  SheetDao._(this._db);

  //DBに挿入する。
  Future<void> insert(Sheet sheet) async {
    debug.log("DAO inserting! : ${sheet.name}");
    Database db = await _db;
    //DBの取得が終わってから実行。idは自動連番のため指定しない。
    db.insert("sheets", {"name": sheet.name});
  }

  Future<List<Sheet>> searchById(int id) async {
    Database db = await _db;
    final List<Map<String, dynamic>> rawData = await db.query(
        'sheets', where: 'id = ?', whereArgs: [id]);

    List<Sheet> sheets = rawData.map((e) => Sheet.fromJson(e)).toList();
    return sheets;
  }

  Future<List<Sheet>> getAll() async {
    Database db = await _db;
    final List<Map<String, dynamic>> rawData = await db.query('sheets');
    return rawData.map((e) => Sheet.fromJson(e)).toList();
  }
}

class LoadingException implements Exception {
  const LoadingException();

  @override
  String toString() => 'Loading...';
}
