import 'dart:async';
import 'package:dart_openai/dart_openai.dart';
import '../models/ai_model.dart';
import 'ai_service.dart';

/// Implementation of [AIService] for OpenAI
class OpenAIService implements AIService {
  OpenAI? _openAI;
  String? _modelId;

  @override
  Future<void> initialize(AIModelConfig config) async {
    if (config.provider != AIProvider.openAI) {
      throw ArgumentError('Invalid provider type for OpenAIService');
    }

    OpenAI.apiKey = config.apiKey;
    _modelId = config.modelId ?? OpenAIModel.gpt35Turbo.modelId;
    _openAI = OpenAI.instance;
  }

  @override
  Future<String> generateResponse(String prompt) async {
    if (_openAI == null) throw StateError('OpenAI service not initialized');

    final completion = await _openAI!.chat.create(
      model: _modelId!,
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: prompt,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );

    return completion.choices.first.message.content ?? '';
  }

  @override
  Stream<String> streamResponse(String prompt) async* {
    if (_openAI == null) throw StateError('OpenAI service not initialized');

    final stream = _openAI!.chat.createStream(
      model: _modelId!,
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: prompt,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );

    await for (final chunk in stream) {
      if (chunk.choices.first.delta.content != null) {
        yield chunk.choices.first.delta.content!;
      }
    }
  }

  @override
  Future<void> dispose() async {
    // No specific cleanup needed for OpenAI
  }
} 