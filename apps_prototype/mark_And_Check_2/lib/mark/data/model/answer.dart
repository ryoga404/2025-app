import 'package:freezed_annotation/freezed_annotation.dart';

import 'answer.dart';
part 'answer.freezed.dart';
@freezed
abstract class Answer with _$Answer {
  const factory Answer(
      int id,
      int index,
      int answer
      ) = _Answer;
}