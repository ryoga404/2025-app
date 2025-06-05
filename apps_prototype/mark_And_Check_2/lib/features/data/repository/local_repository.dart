import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mark_and_check/features/data/dao/sheet_dao.dart';
import 'package:mark_and_check/features/data/model/sheet.dart';
final localRepositoryProvider = Provider((ref) => LocalRepository(ref));
class LocalRepository {
  final SheetDao dao;
  final FutureProvider<List<Sheet>> _allSheetsProvider;
  final Ref ref;

  //コンストラクタでRefを受け取る
  factory LocalRepository(Ref ref){
    final dao = SheetDao(ref); //SheetDaoのインスタンスを作成
    final allSheetsProvider = FutureProvider<List<Sheet>>((ref) async {
      return dao.getAll();
    });
    return LocalRepository._(ref,dao,allSheetsProvider);
  }

  LocalRepository._(this.ref,this.dao ,this._allSheetsProvider);

  Future<void> insertSheets(Sheet sheet) async{
    await dao.insert(sheet);
    ref.invalidate(_allSheetsProvider);
  }

  Future<List<Sheet>> searchSheetsById(int id) => dao.searchById(id);

  FutureProvider<List<Sheet>> getAllSheets() => _allSheetsProvider;

  //TODO 他のメソッドも
}
