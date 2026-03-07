// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SystemStatus {

 String get system; String get nas; String get network; String get butlerAi; String get perimeter; String get timestamp;
/// Create a copy of SystemStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemStatusCopyWith<SystemStatus> get copyWith => _$SystemStatusCopyWithImpl<SystemStatus>(this as SystemStatus, _$identity);

  /// Serializes this SystemStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemStatus&&(identical(other.system, system) || other.system == system)&&(identical(other.nas, nas) || other.nas == nas)&&(identical(other.network, network) || other.network == network)&&(identical(other.butlerAi, butlerAi) || other.butlerAi == butlerAi)&&(identical(other.perimeter, perimeter) || other.perimeter == perimeter)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,system,nas,network,butlerAi,perimeter,timestamp);

@override
String toString() {
  return 'SystemStatus(system: $system, nas: $nas, network: $network, butlerAi: $butlerAi, perimeter: $perimeter, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $SystemStatusCopyWith<$Res>  {
  factory $SystemStatusCopyWith(SystemStatus value, $Res Function(SystemStatus) _then) = _$SystemStatusCopyWithImpl;
@useResult
$Res call({
 String system, String nas, String network, String butlerAi, String perimeter, String timestamp
});




}
/// @nodoc
class _$SystemStatusCopyWithImpl<$Res>
    implements $SystemStatusCopyWith<$Res> {
  _$SystemStatusCopyWithImpl(this._self, this._then);

  final SystemStatus _self;
  final $Res Function(SystemStatus) _then;

/// Create a copy of SystemStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? system = null,Object? nas = null,Object? network = null,Object? butlerAi = null,Object? perimeter = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as String,nas: null == nas ? _self.nas : nas // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,butlerAi: null == butlerAi ? _self.butlerAi : butlerAi // ignore: cast_nullable_to_non_nullable
as String,perimeter: null == perimeter ? _self.perimeter : perimeter // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SystemStatus].
extension SystemStatusPatterns on SystemStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SystemStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SystemStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SystemStatus value)  $default,){
final _that = this;
switch (_that) {
case _SystemStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SystemStatus value)?  $default,){
final _that = this;
switch (_that) {
case _SystemStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String system,  String nas,  String network,  String butlerAi,  String perimeter,  String timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SystemStatus() when $default != null:
return $default(_that.system,_that.nas,_that.network,_that.butlerAi,_that.perimeter,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String system,  String nas,  String network,  String butlerAi,  String perimeter,  String timestamp)  $default,) {final _that = this;
switch (_that) {
case _SystemStatus():
return $default(_that.system,_that.nas,_that.network,_that.butlerAi,_that.perimeter,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String system,  String nas,  String network,  String butlerAi,  String perimeter,  String timestamp)?  $default,) {final _that = this;
switch (_that) {
case _SystemStatus() when $default != null:
return $default(_that.system,_that.nas,_that.network,_that.butlerAi,_that.perimeter,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SystemStatus implements SystemStatus {
  const _SystemStatus({required this.system, required this.nas, required this.network, required this.butlerAi, required this.perimeter, required this.timestamp});
  factory _SystemStatus.fromJson(Map<String, dynamic> json) => _$SystemStatusFromJson(json);

@override final  String system;
@override final  String nas;
@override final  String network;
@override final  String butlerAi;
@override final  String perimeter;
@override final  String timestamp;

/// Create a copy of SystemStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystemStatusCopyWith<_SystemStatus> get copyWith => __$SystemStatusCopyWithImpl<_SystemStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystemStatus&&(identical(other.system, system) || other.system == system)&&(identical(other.nas, nas) || other.nas == nas)&&(identical(other.network, network) || other.network == network)&&(identical(other.butlerAi, butlerAi) || other.butlerAi == butlerAi)&&(identical(other.perimeter, perimeter) || other.perimeter == perimeter)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,system,nas,network,butlerAi,perimeter,timestamp);

@override
String toString() {
  return 'SystemStatus(system: $system, nas: $nas, network: $network, butlerAi: $butlerAi, perimeter: $perimeter, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$SystemStatusCopyWith<$Res> implements $SystemStatusCopyWith<$Res> {
  factory _$SystemStatusCopyWith(_SystemStatus value, $Res Function(_SystemStatus) _then) = __$SystemStatusCopyWithImpl;
@override @useResult
$Res call({
 String system, String nas, String network, String butlerAi, String perimeter, String timestamp
});




}
/// @nodoc
class __$SystemStatusCopyWithImpl<$Res>
    implements _$SystemStatusCopyWith<$Res> {
  __$SystemStatusCopyWithImpl(this._self, this._then);

  final _SystemStatus _self;
  final $Res Function(_SystemStatus) _then;

/// Create a copy of SystemStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? system = null,Object? nas = null,Object? network = null,Object? butlerAi = null,Object? perimeter = null,Object? timestamp = null,}) {
  return _then(_SystemStatus(
system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as String,nas: null == nas ? _self.nas : nas // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,butlerAi: null == butlerAi ? _self.butlerAi : butlerAi // ignore: cast_nullable_to_non_nullable
as String,perimeter: null == perimeter ? _self.perimeter : perimeter // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
