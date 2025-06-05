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
mixin _$answer {

 int get id; int get index; int get answer;
/// Create a copy of answer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$answerCopyWith<answer> get copyWith => _$answerCopyWithImpl<answer>(this as answer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is answer&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode => Object.hash(runtimeType,id,index,answer);

@override
String toString() {
  return 'answer(id: $id, index: $index, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $answerCopyWith<$Res>  {
  factory $answerCopyWith(answer value, $Res Function(answer) _then) = _$answerCopyWithImpl;
@useResult
$Res call({
 int id, int index, int answer
});




}
/// @nodoc
class _$answerCopyWithImpl<$Res>
    implements $answerCopyWith<$Res> {
  _$answerCopyWithImpl(this._self, this._then);

  final answer _self;
  final $Res Function(answer) _then;

/// Create a copy of answer
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


class _answer implements answer {
  const _answer(this.id, this.index, this.answer);
  

@override final  int id;
@override final  int index;
@override final  int answer;

/// Create a copy of answer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$answerCopyWith<_answer> get copyWith => __$answerCopyWithImpl<_answer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _answer&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode => Object.hash(runtimeType,id,index,answer);

@override
String toString() {
  return 'answer(id: $id, index: $index, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$answerCopyWith<$Res> implements $answerCopyWith<$Res> {
  factory _$answerCopyWith(_answer value, $Res Function(_answer) _then) = __$answerCopyWithImpl;
@override @useResult
$Res call({
 int id, int index, int answer
});




}
/// @nodoc
class __$answerCopyWithImpl<$Res>
    implements _$answerCopyWith<$Res> {
  __$answerCopyWithImpl(this._self, this._then);

  final _answer _self;
  final $Res Function(_answer) _then;

/// Create a copy of answer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? index = null,Object? answer = null,}) {
  return _then(_answer(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
