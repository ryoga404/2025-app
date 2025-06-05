import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

//DBのパスを求め、DBを作成・提供するクラス。
class AppDatabaseManager {
  factory AppDatabaseManager(){
    return _instance;
  }

  static final AppDatabaseManager _instance = AppDatabaseManager._();

  AppDatabaseManager._();

  //Databaseとゲッター
  final Future<Database> _db = _getDatabase();
  Future<Database> getDatabase() =>_db;

  //データベースのPathを取得
  static Future<String> _getPath() async {

    String dbFilePath = '';
    if (Platform.isAndroid) {
      dbFilePath = await getDatabasesPath(); // Androidであれば「getDatabasesPath」を利用
    } else if (Platform.isIOS) {
      final dbDirectory =
      await getLibraryDirectory(); // iOSであれば「getLibraryDirectory」を利用
      dbFilePath = dbDirectory.path;
    } else {
      throw Exception(
        'Unable to determine platform.',
      ); // プラットフォームが判別できない場合はExceptionをthrow
    }
    return '$dbFilePath/markAndCheck.db'; //データベースのパス
  }

  static Future<Database> _getDatabase() async {
    String dbFilePath = await _getPath();
    return openDatabase(
      dbFilePath,
      version: 1,

      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON'); //外部キー制約を有効化
      },

      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        //スキーマバージョンが違う時実行
        const upgradeScripts = {
          //スキーマの更新ごとに、ここに前バージョンからのアップグレードのスクリプトを追加。
        };

        for (var i = oldVersion + 1; i <= newVersion; i++) {
          var queries = upgradeScripts[i.toString()]; //アップグレードスクリプトを代入
          for (String query in queries!) {
            await db.execute(query); //バージョンが同じになるまで、queriesを繰り返す。
          }
        }
      },
      //データベースがない時に実行
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE sheets'
              '(id INTEGER PRIMARY KEY, name STRING)',
        ); //sheetsテーブル作成
        await db.execute('''
              CREATE TABLE answers(
              sheet_id INTEGER PRIMARY KEY,
              num INTEGER,
              answer INTEGER,
              
              FOREIGN KEY(sheet_id) 
              REFERENCES sheets(id)
              ON DELETE CASCADE)
              '''); //answersテーブル作成
      },
    );
  }
}
