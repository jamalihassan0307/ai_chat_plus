import 'dart:async';
import 'package:dart_openai/dart_openai.dart';
import '../models/ai_model.dart';
import 'ai_service.dart';

/// Implementation of [AIService] for OpenAI
class OpenAIService implements AIService {
  final String apiKey;
  late final OpenAI _openAI;

  OpenAIService({required this.apiKey}) {
    OpenAI.apiKey = apiKey;
    _openAI = OpenAI.instance;
  }

  @override
  Future<void> initialize(AIModelConfig config) async {
    if (config.provider != AIProvider.openAI) {
      throw ArgumentError('Invalid provider type for OpenAIService');
    }
    // OpenAI is already initialized in constructor
  }

  @override
  Future<String> generateResponse(String prompt) async {
    try {
      final response = await _openAI.chat.create(
        model: 'gpt-3.5-turbo',
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );

      return response.choices.first.message.content?.first.text ?? '';
    } catch (e) {
      throw Exception('OpenAI Error: $e');
    }
  }

  @override
  Stream<String> streamResponse(String prompt) async* {
    try {
      final stream = _openAI.chat.createStream(
        model: 'gpt-3.5-turbo',
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );

      await for (final res in stream) {
        if (res.choices.first.delta.content?.isNotEmpty ?? false) {
          yield res.choices.first.delta.content?.first?.text ?? '';
        }
      }
    } catch (e) {
      throw Exception('OpenAI Stream Error: $e');
    }
  }

  @override
  Future<void> dispose() async {
    // No cleanup needed for OpenAI
  }
}
