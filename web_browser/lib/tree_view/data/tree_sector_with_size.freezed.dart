// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tree_sector_with_size.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TreeSectorWithSize implements DiagnosticableTreeMixin {

 TreeDivision get treeSector; Size get size;
/// Create a copy of TreeSectorWithSize
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TreeSectorWithSizeCopyWith<TreeDivisionWithSize> get copyWith => _$TreeSectorWithSizeCopyWithImpl<TreeDivisionWithSize>(this as TreeDivisionWithSize, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TreeSectorWithSize'))
    ..add(DiagnosticsProperty('treeSector', treeSector))..add(DiagnosticsProperty('size', size));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TreeDivisionWithSize&&(identical(other.treeSector, treeSector) || other.treeSector == treeSector)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode => Object.hash(runtimeType,treeSector,size);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TreeSectorWithSize(treeSector: $treeSector, size: $size)';
}


}

/// @nodoc
abstract mixin class $TreeSectorWithSizeCopyWith<$Res>  {
  factory $TreeSectorWithSizeCopyWith(TreeDivisionWithSize value, $Res Function(TreeDivisionWithSize) _then) = _$TreeSectorWithSizeCopyWithImpl;
@useResult
$Res call({
 TreeDivision treeSector, Size size
});




}
/// @nodoc
class _$TreeSectorWithSizeCopyWithImpl<$Res>
    implements $TreeSectorWithSizeCopyWith<$Res> {
  _$TreeSectorWithSizeCopyWithImpl(this._self, this._then);

  final TreeDivisionWithSize _self;
  final $Res Function(TreeDivisionWithSize) _then;

/// Create a copy of TreeSectorWithSize
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? treeSector = null,Object? size = null,}) {
  return _then(_self.copyWith(
treeSector: null == treeSector ? _self.treeSector : treeSector // ignore: cast_nullable_to_non_nullable
as TreeDivision,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,
  ));
}

}


/// Adds pattern-matching-related methods to [TreeDivisionWithSize].
extension TreeSectorWithSizePatterns on TreeDivisionWithSize {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TreeSectorWithSize value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TreeSectorWithSize() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TreeSectorWithSize value)  $default,){
final _that = this;
switch (_that) {
case _TreeSectorWithSize():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TreeSectorWithSize value)?  $default,){
final _that = this;
switch (_that) {
case _TreeSectorWithSize() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TreeDivision treeSector,  Size size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TreeSectorWithSize() when $default != null:
return $default(_that.treeSector,_that.size);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TreeDivision treeSector,  Size size)  $default,) {final _that = this;
switch (_that) {
case _TreeSectorWithSize():
return $default(_that.treeSector,_that.size);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TreeDivision treeSector,  Size size)?  $default,) {final _that = this;
switch (_that) {
case _TreeSectorWithSize() when $default != null:
return $default(_that.treeSector,_that.size);case _:
  return null;

}
}

}

/// @nodoc


class _TreeSectorWithSize with DiagnosticableTreeMixin implements TreeDivisionWithSize {
  const _TreeSectorWithSize({required this.treeSector, required this.size});
  

@override final  TreeDivision treeSector;
@override final  Size size;

/// Create a copy of TreeSectorWithSize
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TreeSectorWithSizeCopyWith<_TreeSectorWithSize> get copyWith => __$TreeSectorWithSizeCopyWithImpl<_TreeSectorWithSize>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TreeSectorWithSize'))
    ..add(DiagnosticsProperty('treeSector', treeSector))..add(DiagnosticsProperty('size', size));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TreeSectorWithSize&&(identical(other.treeSector, treeSector) || other.treeSector == treeSector)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode => Object.hash(runtimeType,treeSector,size);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TreeSectorWithSize(treeSector: $treeSector, size: $size)';
}


}

/// @nodoc
abstract mixin class _$TreeSectorWithSizeCopyWith<$Res> implements $TreeSectorWithSizeCopyWith<$Res> {
  factory _$TreeSectorWithSizeCopyWith(_TreeSectorWithSize value, $Res Function(_TreeSectorWithSize) _then) = __$TreeSectorWithSizeCopyWithImpl;
@override @useResult
$Res call({
 TreeDivision treeSector, Size size
});




}
/// @nodoc
class __$TreeSectorWithSizeCopyWithImpl<$Res>
    implements _$TreeSectorWithSizeCopyWith<$Res> {
  __$TreeSectorWithSizeCopyWithImpl(this._self, this._then);

  final _TreeSectorWithSize _self;
  final $Res Function(_TreeSectorWithSize) _then;

/// Create a copy of TreeSectorWithSize
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? treeSector = null,Object? size = null,}) {
  return _then(_TreeSectorWithSize(
treeSector: null == treeSector ? _self.treeSector : treeSector // ignore: cast_nullable_to_non_nullable
as TreeDivision,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,
  ));
}


}

// dart format on
