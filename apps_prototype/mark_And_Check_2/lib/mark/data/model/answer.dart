import 'package:freezed_annotation/freezed_annotation.dart';
part 'answer.freezed.dart';
@freezed
class answer with _$answer {
  const factory answer(
      int id,
      int index,
      int answer
      ) = _answer;
}
