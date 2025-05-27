import 'package:freezed_annotation/freezed_annotation.dart';

part 'sheet.freezed.dart';
part 'sheet.g.dart';

@freezed
abstract class Sheet with _$Sheet {

  const factory Sheet(
      String name,
      int id,
      ) = _Sheet;

  factory Sheet.fromJson(Map<String, dynamic> json) => _$SheetFromJson(json);
}