import 'dart:async';
import '../models/ai_model.dart';
import 'openai_service.dart';
import 'gemini_service.dart';
import 'claude_service.dart';

/// Abstract class defining the interface for AI services
abstract class AIService {
  /// Initialize the AI service with configuration
  Future<void> initialize(AIModelConfig config);

  /// Generate a response for the given prompt
  Future<String> generateResponse(String prompt);

  /// Stream response tokens for real-time chat responses
  Stream<String> streamResponse(String prompt);

  /// Clean up resources used by the service
  Future<void> dispose();
}

/// Factory for creating AI service instances based on provider
class AIServiceFactory {
  static AIService createService(AIProvider provider) {
    switch (provider) {
      case AIProvider.openAI:
        return OpenAIService(
            apiKey: ''); // apiKey will be set during initialize
      case AIProvider.gemini:
        return GeminiService(
            apiKey: ''); // apiKey will be set during initialize
      case AIProvider.claude:
        return ClaudeService(
            apiKey: ''); // apiKey will be set during initialize
    }
  }
}

class AIChat {
  final String apiKey;
  final AIProvider provider;
  late final AIService _service;

  AIChat({
    required this.apiKey,
    required this.provider,
  }) {
    _initService();
  }

  void _initService() {
    switch (provider) {
      case AIProvider.openAI:
        _service = OpenAIService(apiKey: apiKey);
      case AIProvider.gemini:
        _service = GeminiService(apiKey: apiKey);
      case AIProvider.claude:
        _service = ClaudeService(apiKey: apiKey);
    }
  }

  Future<String> generateResponse(String prompt) async {
    return _service.generateResponse(prompt);
  }

  Stream<String> streamResponse(String prompt) {
    return _service.streamResponse(prompt);
  }

  Future<void> dispose() async {
    await _service.dispose();
  }
}
