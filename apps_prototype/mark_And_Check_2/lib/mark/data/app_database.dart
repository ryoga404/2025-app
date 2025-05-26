import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/mark/data/model/answer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final appDatabaseManagerProvider = Provider((ref) {
  return AppDatabaseManager();
}); //データベースのインスタンスを作成し、以降はインスタンスを返す

class AppDatabaseManager {
  late Database db;

  AppDatabaseManager() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    var dbFilePath = '';

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

    dbFilePath = '$dbFilePath/markAndCheck.db'; //データベースのパス

    db = await openDatabase(
      dbFilePath,
      version: 1,

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

      onCreate: (Database db, int version) async {
        //データベースがない時に実行

        await db.execute(
          'CREATE TABLE sheets'
          '(id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING',
        ); //sheetsテーブル作成
        await db.execute('''CREATE TABLE answers(
              id INTEGER PRIMARY KEY,
              index INTEGER,
              answer INTEGER,
              
              FOREIGN KEY(id) REFERENCES sheets(id))'''); //answersテーブル作成
      },
    );
  }
}
