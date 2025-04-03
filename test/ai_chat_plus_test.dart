import 'package:flutter_test/flutter_test.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';

void main() {
  group('AIModelConfig Tests', () {
    test('Creates config with required parameters', () {
      final config = AIModelConfig(
        provider: AIProvider.openAI,
        apiKey: 'test_key',
      );

      expect(config.provider, equals(AIProvider.openAI));
      expect(config.apiKey, equals('test_key'));
      expect(config.modelId, isNull);
      expect(config.additionalConfig, isNull);
    });

    test('Creates config with all parameters', () {
      final config = AIModelConfig(
        provider: AIProvider.gemini,
        apiKey: 'test_key',
        modelId: 'custom_model',
        additionalConfig: {'temperature': 0.7},
      );

      expect(config.provider, equals(AIProvider.gemini));
      expect(config.apiKey, equals('test_key'));
      expect(config.modelId, equals('custom_model'));
      expect(config.additionalConfig?['temperature'], equals(0.7));
    });
  });

  group('AIServiceFactory Tests', () {
    test('Creates OpenAI service', () {
      final service = AIServiceFactory.createService(AIProvider.openAI);
      expect(service, isA<AIService>());
    });

    test('Creates Gemini service', () {
      final service = AIServiceFactory.createService(AIProvider.gemini);
      expect(service, isA<AIService>());
    });

    test('Creates Claude service', () {
      final service = AIServiceFactory.createService(AIProvider.claude);
      expect(service, isA<AIService>());
    });
  });

  group('Model ID Tests', () {
    test('OpenAI model IDs are correct', () {
      expect(OpenAIModel.gpt35Turbo.modelId, equals('gpt-3.5-turbo'));
      expect(OpenAIModel.gpt4.modelId, equals('gpt-4'));
      expect(OpenAIModel.gpt4Turbo.modelId, equals('gpt-4-turbo-preview'));
    });

    test('Gemini model IDs are correct', () {
      expect(GeminiModel.geminiPro.modelId, equals('gemini-pro'));
      expect(GeminiModel.geminiPro15.modelId, equals('gemini-pro-1.5'));
      expect(GeminiModel.geminiFlash.modelId, equals('gemini-1.5-flash'));
    });

    test('Claude model IDs are correct', () {
      expect(ClaudeModel.claude3Sonnet.modelId, equals('claude-3-sonnet-20240229'));
      expect(ClaudeModel.claude3Opus.modelId, equals('claude-3-opus-20240229'));
      expect(ClaudeModel.claude3Haiku.modelId, equals('claude-3-haiku-20240307'));
    });
  });

  group('AIResponse Tests', () {
    test('Creates AIResponse and converts to/from JSON', () {
      final response = AIResponse(
        text: 'Test response',
        provider: AIProvider.openAI,
      );

      final json = response.toJson();
      final fromJson = AIResponse.fromJson(json);

      expect(fromJson.text, equals('Test response'));
      expect(fromJson.provider, equals(AIProvider.openAI));
    });
  });

  group('Service Initialization Tests', () {
    test('Services require initialization before use', () async {
      final services = [
        AIServiceFactory.createService(AIProvider.openAI),
        AIServiceFactory.createService(AIProvider.gemini),
        AIServiceFactory.createService(AIProvider.claude),
      ];

      for (final service in services) {
        expect(
          () => service.generateResponse('test'),
          throwsA(isA<StateError>()),
        );
      }
    });
  });
}
