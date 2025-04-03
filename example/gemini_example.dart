import 'package:ai_chat_plus/ai_chat_plus.dart';

void main() async {
  print('Gemini Chat Example\n');

  // Initialize Gemini configuration
  final config = AIModelConfig(
    provider: AIProvider.googleGemini,
    apiKey: 'YOUR_GEMINI_API_KEY', // Replace with your Gemini API key
    modelId: GeminiModel.geminiPro.modelId,
  );

  // Create and initialize the Gemini service
  final aiService = AIServiceFactory.createService(AIProvider.googleGemini);
  await aiService.initialize(config);

  try {
    // Example 1: Simple response generation
    print('Example 1: Simple Response\n');
    print('Generating response...');
    final response = await aiService.generateResponse(
      'Explain quantum computing in simple terms.'
    );
    print('Gemini Response: $response\n');

    // Example 2: Streaming response
    print('Example 2: Streaming Response\n');
    print('Streaming response...');
    aiService.streamResponse(
      'Write a haiku about artificial intelligence.'
    ).listen(
      (chunk) => print(chunk), // Print each chunk as it arrives
      onDone: () => print('\nHaiku complete!'),
      onError: (error) => print('Error: $error'),
    );
  } catch (e) {
    print('Error: $e');
  } finally {
    // Clean up resources
    await aiService.dispose();
  }
} 