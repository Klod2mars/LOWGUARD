// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SensorEntity {

 String get id; String get name; String get type; bool get isActive; String? get lastReading;
/// Create a copy of SensorEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorEntityCopyWith<SensorEntity> get copyWith => _$SensorEntityCopyWithImpl<SensorEntity>(this as SensorEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SensorEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastReading, lastReading) || other.lastReading == lastReading));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,isActive,lastReading);

@override
String toString() {
  return 'SensorEntity(id: $id, name: $name, type: $type, isActive: $isActive, lastReading: $lastReading)';
}


}

/// @nodoc
abstract mixin class $SensorEntityCopyWith<$Res>  {
  factory $SensorEntityCopyWith(SensorEntity value, $Res Function(SensorEntity) _then) = _$SensorEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, bool isActive, String? lastReading
});




}
/// @nodoc
class _$SensorEntityCopyWithImpl<$Res>
    implements $SensorEntityCopyWith<$Res> {
  _$SensorEntityCopyWithImpl(this._self, this._then);

  final SensorEntity _self;
  final $Res Function(SensorEntity) _then;

/// Create a copy of SensorEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? isActive = null,Object? lastReading = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastReading: freezed == lastReading ? _self.lastReading : lastReading // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SensorEntity].
extension SensorEntityPatterns on SensorEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SensorEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SensorEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SensorEntity value)  $default,){
final _that = this;
switch (_that) {
case _SensorEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SensorEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SensorEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  bool isActive,  String? lastReading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SensorEntity() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.isActive,_that.lastReading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  bool isActive,  String? lastReading)  $default,) {final _that = this;
switch (_that) {
case _SensorEntity():
return $default(_that.id,_that.name,_that.type,_that.isActive,_that.lastReading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  bool isActive,  String? lastReading)?  $default,) {final _that = this;
switch (_that) {
case _SensorEntity() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.isActive,_that.lastReading);case _:
  return null;

}
}

}

/// @nodoc


class _SensorEntity implements SensorEntity {
  const _SensorEntity({required this.id, required this.name, required this.type, required this.isActive, this.lastReading});
  

@override final  String id;
@override final  String name;
@override final  String type;
@override final  bool isActive;
@override final  String? lastReading;

/// Create a copy of SensorEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorEntityCopyWith<_SensorEntity> get copyWith => __$SensorEntityCopyWithImpl<_SensorEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SensorEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastReading, lastReading) || other.lastReading == lastReading));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,isActive,lastReading);

@override
String toString() {
  return 'SensorEntity(id: $id, name: $name, type: $type, isActive: $isActive, lastReading: $lastReading)';
}


}

/// @nodoc
abstract mixin class _$SensorEntityCopyWith<$Res> implements $SensorEntityCopyWith<$Res> {
  factory _$SensorEntityCopyWith(_SensorEntity value, $Res Function(_SensorEntity) _then) = __$SensorEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, bool isActive, String? lastReading
});




}
/// @nodoc
class __$SensorEntityCopyWithImpl<$Res>
    implements _$SensorEntityCopyWith<$Res> {
  __$SensorEntityCopyWithImpl(this._self, this._then);

  final _SensorEntity _self;
  final $Res Function(_SensorEntity) _then;

/// Create a copy of SensorEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? isActive = null,Object? lastReading = freezed,}) {
  return _then(_SensorEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastReading: freezed == lastReading ? _self.lastReading : lastReading // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$IntruderEntity {

 String get id; DateTime get detectedAt; String get location; String? get imageUrl; bool get isIdentified;
/// Create a copy of IntruderEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntruderEntityCopyWith<IntruderEntity> get copyWith => _$IntruderEntityCopyWithImpl<IntruderEntity>(this as IntruderEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntruderEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isIdentified, isIdentified) || other.isIdentified == isIdentified));
}


@override
int get hashCode => Object.hash(runtimeType,id,detectedAt,location,imageUrl,isIdentified);

@override
String toString() {
  return 'IntruderEntity(id: $id, detectedAt: $detectedAt, location: $location, imageUrl: $imageUrl, isIdentified: $isIdentified)';
}


}

/// @nodoc
abstract mixin class $IntruderEntityCopyWith<$Res>  {
  factory $IntruderEntityCopyWith(IntruderEntity value, $Res Function(IntruderEntity) _then) = _$IntruderEntityCopyWithImpl;
@useResult
$Res call({
 String id, DateTime detectedAt, String location, String? imageUrl, bool isIdentified
});




}
/// @nodoc
class _$IntruderEntityCopyWithImpl<$Res>
    implements $IntruderEntityCopyWith<$Res> {
  _$IntruderEntityCopyWithImpl(this._self, this._then);

  final IntruderEntity _self;
  final $Res Function(IntruderEntity) _then;

/// Create a copy of IntruderEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? detectedAt = null,Object? location = null,Object? imageUrl = freezed,Object? isIdentified = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isIdentified: null == isIdentified ? _self.isIdentified : isIdentified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IntruderEntity].
extension IntruderEntityPatterns on IntruderEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntruderEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntruderEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntruderEntity value)  $default,){
final _that = this;
switch (_that) {
case _IntruderEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntruderEntity value)?  $default,){
final _that = this;
switch (_that) {
case _IntruderEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime detectedAt,  String location,  String? imageUrl,  bool isIdentified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntruderEntity() when $default != null:
return $default(_that.id,_that.detectedAt,_that.location,_that.imageUrl,_that.isIdentified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime detectedAt,  String location,  String? imageUrl,  bool isIdentified)  $default,) {final _that = this;
switch (_that) {
case _IntruderEntity():
return $default(_that.id,_that.detectedAt,_that.location,_that.imageUrl,_that.isIdentified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime detectedAt,  String location,  String? imageUrl,  bool isIdentified)?  $default,) {final _that = this;
switch (_that) {
case _IntruderEntity() when $default != null:
return $default(_that.id,_that.detectedAt,_that.location,_that.imageUrl,_that.isIdentified);case _:
  return null;

}
}

}

/// @nodoc


class _IntruderEntity implements IntruderEntity {
  const _IntruderEntity({required this.id, required this.detectedAt, required this.location, this.imageUrl, this.isIdentified = false});
  

@override final  String id;
@override final  DateTime detectedAt;
@override final  String location;
@override final  String? imageUrl;
@override@JsonKey() final  bool isIdentified;

/// Create a copy of IntruderEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntruderEntityCopyWith<_IntruderEntity> get copyWith => __$IntruderEntityCopyWithImpl<_IntruderEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntruderEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isIdentified, isIdentified) || other.isIdentified == isIdentified));
}


@override
int get hashCode => Object.hash(runtimeType,id,detectedAt,location,imageUrl,isIdentified);

@override
String toString() {
  return 'IntruderEntity(id: $id, detectedAt: $detectedAt, location: $location, imageUrl: $imageUrl, isIdentified: $isIdentified)';
}


}

/// @nodoc
abstract mixin class _$IntruderEntityCopyWith<$Res> implements $IntruderEntityCopyWith<$Res> {
  factory _$IntruderEntityCopyWith(_IntruderEntity value, $Res Function(_IntruderEntity) _then) = __$IntruderEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime detectedAt, String location, String? imageUrl, bool isIdentified
});




}
/// @nodoc
class __$IntruderEntityCopyWithImpl<$Res>
    implements _$IntruderEntityCopyWith<$Res> {
  __$IntruderEntityCopyWithImpl(this._self, this._then);

  final _IntruderEntity _self;
  final $Res Function(_IntruderEntity) _then;

/// Create a copy of IntruderEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? detectedAt = null,Object? location = null,Object? imageUrl = freezed,Object? isIdentified = null,}) {
  return _then(_IntruderEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isIdentified: null == isIdentified ? _self.isIdentified : isIdentified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
