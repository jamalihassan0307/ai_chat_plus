library ai_chat_plus;

export 'src/models/ai_model.dart';
export 'src/services/ai_service.dart';
export 'src/services/openai_service.dart';

/// Main widget for AI Chat Plus
class AIChat {
  final String apiKey;
  final String? assistantModel;

  AIChat({
    required this.apiKey,
    this.assistantModel,
  });

  // Implementation will be added in future updates
}

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
