

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/mark/data/dao/sheet_dao.dart';
import 'package:mark_and_check/mark/data/model/sheet.dart';

final LocalRepositoryProvider = Provider((ref)=>LocalRepository(ref));

class LocalRepository{
  late Ref ref;
  late SheetDao dao;
  LocalRepository(Ref inputRef){
    ref = inputRef;//コンストラクタからRefを受け取る
    dao = SheetDao(ref);//SheetDaoのインスタンスを作成
  }

  insertSheets(Sheet sheet){
    dao.insert(sheet);
  }
  //TODO 他のメソッドも
}