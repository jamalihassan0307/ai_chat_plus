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
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)
          ],
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );

    final content = completion.choices.first.message.content;
    if (content == null || content.isEmpty) return '';
    return content.first.text ?? '';
  }

  @override
  Stream<String> streamResponse(String prompt) async* {
    if (_openAI == null) throw StateError('OpenAI service not initialized');

    final stream = _openAI!.chat.createStream(
      model: _modelId!,
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)
          ],
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );

    await for (final chunk in stream) {
      final content = chunk.choices.first.delta.content;
      if (content != null && content.isNotEmpty && content.first != null) {
        yield content.first?.text ?? '';
      }
    }
  }

  @override
  Future<void> dispose() async {
    // No specific cleanup needed for OpenAI
  }
} 