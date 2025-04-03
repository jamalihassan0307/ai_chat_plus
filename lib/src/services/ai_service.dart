import '../models/ai_model.dart';

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
        throw UnimplementedError('OpenAI service not yet implemented');
      case AIProvider.googleGemini:
        throw UnimplementedError('Google Gemini service not yet implemented');
      case AIProvider.claude:
        throw UnimplementedError('Claude service not yet implemented');
      case AIProvider.custom:
        throw UnimplementedError('Custom AI service not yet implemented');
    }
  }
}
