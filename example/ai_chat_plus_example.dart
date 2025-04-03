import 'package:ai_chat_plus/ai_chat_plus.dart';

void main() async {
  // Initialize OpenAI configuration
  final config = AIModelConfig(
    provider: AIProvider.openAI,
    apiKey: 'YOUR_OPENAI_API_KEY', // Replace with your OpenAI API key
    modelId: OpenAIModel.gpt35Turbo.modelId,
  );

  // Create and initialize the OpenAI service
  final aiService = AIServiceFactory.createService(AIProvider.openAI);
  await aiService.initialize(config);

  try {
    // Example 1: Simple response generation
    print('Generating response...');
    final response = await aiService.generateResponse(
      'What are the three laws of robotics?'
    );
    print('AI Response: $response\n');

    // Example 2: Streaming response
    print('Streaming response...');
    aiService.streamResponse(
      'Tell me a short story about a robot learning to paint.'
    ).listen(
      (chunk) => print(chunk), // Print each chunk as it arrives
      onDone: () => print('\nStory complete!'),
      onError: (error) => print('Error: $error'),
    );
  } catch (e) {
    print('Error: $e');
  } finally {
    // Clean up resources
    await aiService.dispose();
  }
} 