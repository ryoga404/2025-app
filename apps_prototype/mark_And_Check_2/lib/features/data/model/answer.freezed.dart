// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Answer {

 int get id; int get index; int get answer;
/// Create a copy of Answer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerCopyWith<Answer> get copyWith => _$AnswerCopyWithImpl<Answer>(this as Answer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Answer&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode => Object.hash(runtimeType,id,index,answer);

@override
String toString() {
  return 'Answer(id: $id, index: $index, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $AnswerCopyWith<$Res>  {
  factory $AnswerCopyWith(Answer value, $Res Function(Answer) _then) = _$AnswerCopyWithImpl;
@useResult
$Res call({
 int id, int index, int answer
});




}
/// @nodoc
class _$AnswerCopyWithImpl<$Res>
    implements $AnswerCopyWith<$Res> {
  _$AnswerCopyWithImpl(this._self, this._then);

  final Answer _self;
  final $Res Function(Answer) _then;

/// Create a copy of Answer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? index = null,Object? answer = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _Answer implements Answer {
  const _Answer(this.id, this.index, this.answer);
  

@override final  int id;
@override final  int index;
@override final  int answer;

/// Create a copy of Answer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerCopyWith<_Answer> get copyWith => __$AnswerCopyWithImpl<_Answer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Answer&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode => Object.hash(runtimeType,id,index,answer);

@override
String toString() {
  return 'Answer(id: $id, index: $index, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$AnswerCopyWith<$Res> implements $AnswerCopyWith<$Res> {
  factory _$AnswerCopyWith(_Answer value, $Res Function(_Answer) _then) = __$AnswerCopyWithImpl;
@override @useResult
$Res call({
 int id, int index, int answer
});




}
/// @nodoc
class __$AnswerCopyWithImpl<$Res>
    implements _$AnswerCopyWith<$Res> {
  __$AnswerCopyWithImpl(this._self, this._then);

  final _Answer _self;
  final $Res Function(_Answer) _then;

/// Create a copy of Answer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? index = null,Object? answer = null,}) {
  return _then(_Answer(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
