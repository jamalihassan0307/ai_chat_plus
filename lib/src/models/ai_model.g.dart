// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIModelConfigImpl _$$AIModelConfigImplFromJson(Map<String, dynamic> json) =>
    _$AIModelConfigImpl(
      provider: $enumDecode(_$AIProviderEnumMap, json['provider']),
      apiKey: json['apiKey'] as String,
      modelId: json['modelId'] as String?,
      additionalConfig: json['additionalConfig'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AIModelConfigImplToJson(_$AIModelConfigImpl instance) =>
    <String, dynamic>{
      'provider': _$AIProviderEnumMap[instance.provider]!,
      'apiKey': instance.apiKey,
      'modelId': instance.modelId,
      'additionalConfig': instance.additionalConfig,
    };

const _$AIProviderEnumMap = {
  AIProvider.openAI: 'openAI',
  AIProvider.gemini: 'gemini',
};
