// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Sheet {

 String get name; int get id;
/// Create a copy of Sheet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SheetCopyWith<Sheet> get copyWith => _$SheetCopyWithImpl<Sheet>(this as Sheet, _$identity);

  /// Serializes this Sheet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sheet&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id);

@override
String toString() {
  return 'Sheet(name: $name, id: $id)';
}


}

/// @nodoc
abstract mixin class $SheetCopyWith<$Res>  {
  factory $SheetCopyWith(Sheet value, $Res Function(Sheet) _then) = _$SheetCopyWithImpl;
@useResult
$Res call({
 String name, int id
});




}
/// @nodoc
class _$SheetCopyWithImpl<$Res>
    implements $SheetCopyWith<$Res> {
  _$SheetCopyWithImpl(this._self, this._then);

  final Sheet _self;
  final $Res Function(Sheet) _then;

/// Create a copy of Sheet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? id = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Sheet implements Sheet {
  const _Sheet(this.name, this.id);
  factory _Sheet.fromJson(Map<String, dynamic> json) => _$SheetFromJson(json);

@override final  String name;
@override final  int id;

/// Create a copy of Sheet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SheetCopyWith<_Sheet> get copyWith => __$SheetCopyWithImpl<_Sheet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SheetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sheet&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id);

@override
String toString() {
  return 'Sheet(name: $name, id: $id)';
}


}

/// @nodoc
abstract mixin class _$SheetCopyWith<$Res> implements $SheetCopyWith<$Res> {
  factory _$SheetCopyWith(_Sheet value, $Res Function(_Sheet) _then) = __$SheetCopyWithImpl;
@override @useResult
$Res call({
 String name, int id
});




}
/// @nodoc
class __$SheetCopyWithImpl<$Res>
    implements _$SheetCopyWith<$Res> {
  __$SheetCopyWithImpl(this._self, this._then);

  final _Sheet _self;
  final $Res Function(_Sheet) _then;

/// Create a copy of Sheet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? id = null,}) {
  return _then(_Sheet(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
