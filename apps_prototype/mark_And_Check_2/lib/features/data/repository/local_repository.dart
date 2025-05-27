import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/features/data/dao/sheet_dao.dart';
import 'package:mark_and_check/features/data/model/sheet.dart';

class LocalRepository {
  late SheetDao dao;
  late final  sheetsProvider;

  //コンストラクタでRefを受け取る
  LocalRepository(Ref inputRef) {
    dao = SheetDao(inputRef); //SheetDaoのインスタンスを作成

    //FutureProviderとして、Sheetsの値を提供
    sheetsProvider = FutureProvider<List<Sheet>>((ref) async {
      return dao.getAll();
    });
  }

  insertSheets(Sheet sheet) {
    dao.insert(sheet);
  }

  //TODO 他のメソッドも
}
