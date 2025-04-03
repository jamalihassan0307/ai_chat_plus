// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIModelConfig _$AIModelConfigFromJson(Map<String, dynamic> json) {
  return _AIModelConfig.fromJson(json);
}

/// @nodoc
mixin _$AIModelConfig {
  AIProvider get provider => throw _privateConstructorUsedError;
  String get apiKey => throw _privateConstructorUsedError;
  String? get modelId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get additionalConfig =>
      throw _privateConstructorUsedError;

  /// Serializes this AIModelConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIModelConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIModelConfigCopyWith<AIModelConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIModelConfigCopyWith<$Res> {
  factory $AIModelConfigCopyWith(
          AIModelConfig value, $Res Function(AIModelConfig) then) =
      _$AIModelConfigCopyWithImpl<$Res, AIModelConfig>;
  @useResult
  $Res call(
      {AIProvider provider,
      String apiKey,
      String? modelId,
      Map<String, dynamic>? additionalConfig});
}

/// @nodoc
class _$AIModelConfigCopyWithImpl<$Res, $Val extends AIModelConfig>
    implements $AIModelConfigCopyWith<$Res> {
  _$AIModelConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIModelConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? apiKey = null,
    Object? modelId = freezed,
    Object? additionalConfig = freezed,
  }) {
    return _then(_value.copyWith(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as AIProvider,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalConfig: freezed == additionalConfig
          ? _value.additionalConfig
          : additionalConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIModelConfigImplCopyWith<$Res>
    implements $AIModelConfigCopyWith<$Res> {
  factory _$$AIModelConfigImplCopyWith(
          _$AIModelConfigImpl value, $Res Function(_$AIModelConfigImpl) then) =
      __$$AIModelConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AIProvider provider,
      String apiKey,
      String? modelId,
      Map<String, dynamic>? additionalConfig});
}

/// @nodoc
class __$$AIModelConfigImplCopyWithImpl<$Res>
    extends _$AIModelConfigCopyWithImpl<$Res, _$AIModelConfigImpl>
    implements _$$AIModelConfigImplCopyWith<$Res> {
  __$$AIModelConfigImplCopyWithImpl(
      _$AIModelConfigImpl _value, $Res Function(_$AIModelConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIModelConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? apiKey = null,
    Object? modelId = freezed,
    Object? additionalConfig = freezed,
  }) {
    return _then(_$AIModelConfigImpl(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as AIProvider,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalConfig: freezed == additionalConfig
          ? _value._additionalConfig
          : additionalConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIModelConfigImpl implements _AIModelConfig {
  const _$AIModelConfigImpl(
      {required this.provider,
      required this.apiKey,
      this.modelId,
      final Map<String, dynamic>? additionalConfig})
      : _additionalConfig = additionalConfig;

  factory _$AIModelConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIModelConfigImplFromJson(json);

  @override
  final AIProvider provider;
  @override
  final String apiKey;
  @override
  final String? modelId;
  final Map<String, dynamic>? _additionalConfig;
  @override
  Map<String, dynamic>? get additionalConfig {
    final value = _additionalConfig;
    if (value == null) return null;
    if (_additionalConfig is EqualUnmodifiableMapView) return _additionalConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AIModelConfig(provider: $provider, apiKey: $apiKey, modelId: $modelId, additionalConfig: $additionalConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIModelConfigImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            const DeepCollectionEquality()
                .equals(other._additionalConfig, _additionalConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, provider, apiKey, modelId,
      const DeepCollectionEquality().hash(_additionalConfig));

  /// Create a copy of AIModelConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIModelConfigImplCopyWith<_$AIModelConfigImpl> get copyWith =>
      __$$AIModelConfigImplCopyWithImpl<_$AIModelConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIModelConfigImplToJson(
      this,
    );
  }
}

abstract class _AIModelConfig implements AIModelConfig {
  const factory _AIModelConfig(
      {required final AIProvider provider,
      required final String apiKey,
      final String? modelId,
      final Map<String, dynamic>? additionalConfig}) = _$AIModelConfigImpl;

  factory _AIModelConfig.fromJson(Map<String, dynamic> json) =
      _$AIModelConfigImpl.fromJson;

  @override
  AIProvider get provider;
  @override
  String get apiKey;
  @override
  String? get modelId;
  @override
  Map<String, dynamic>? get additionalConfig;

  /// Create a copy of AIModelConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIModelConfigImplCopyWith<_$AIModelConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
