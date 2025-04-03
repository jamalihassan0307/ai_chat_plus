library ai_chat_plus;

export 'src/controllers/chat_controller.dart';
export 'src/models/chat_message.dart';
export 'src/widgets/chat_widget.dart';
export 'src/theme/chat_theme.dart';

/// The main configuration class for AI Chat Plus
class AIChatConfig {
  /// API key for the AI service
  final String apiKey;
  
  /// Base URL for the AI service
  final String baseUrl;
  
  /// Maximum number of retry attempts for failed requests
  final int maxRetries;
  
  /// Whether to enable message persistence
  final bool enablePersistence;

  const AIChatConfig({
    required this.apiKey,
    this.baseUrl = 'https://api.example.com',
    this.maxRetries = 3,
    this.enablePersistence = true,
  });
}

/// Main controller for managing chat state and interactions
class AIChatController {
  final AIChatConfig config;
  
  AIChatController({
    required this.config,
  });

  /// Send a message to the AI service
  Future<void> sendMessage(String message) async {
    // TODO: Implement message sending logic
  }

  /// Clear chat history
  void clearHistory() {
    // TODO: Implement history clearing
  }
}
