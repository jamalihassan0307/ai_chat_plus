import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_model.freezed.dart';
part 'ai_model.g.dart';

/// Enum representing different AI providers
enum AIProvider {
  openAI,
  googleGemini,
  claude,
  custom
}

/// Enum representing different OpenAI models
enum OpenAIModel {
  gpt35Turbo('gpt-3.5-turbo'),
  gpt4('gpt-4'),
  gpt4Turbo('gpt-4-turbo-preview');

  final String modelId;
  const OpenAIModel(this.modelId);
}

/// Enum representing different Gemini models
enum GeminiModel {
  geminiPro('gemini-pro'),
  geminiPro15('gemini-pro-1.5');

  final String modelId;
  const GeminiModel(this.modelId);
}

/// Configuration for AI model settings
@freezed
class AIModelConfig with _$AIModelConfig {
  const factory AIModelConfig({
    required AIProvider provider,
    required String apiKey,
    String? modelId,
    Map<String, dynamic>? additionalConfig,
  }) = _AIModelConfig;

  factory AIModelConfig.fromJson(Map<String, dynamic> json) => 
      _$AIModelConfigFromJson(json);
} 