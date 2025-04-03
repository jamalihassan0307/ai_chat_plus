<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# AI Chat Plus

A Flutter package that provides AI chat functionality with enhanced features including OpenAI, Google Gemini, and Claude AI integrations, voice recognition, and multimodal support.

## Features

Currently Implemented:
- 🤖 OpenAI GPT Integration (3.5/4/4-turbo)
- 🔄 Streaming responses support
- 🎯 Type-safe API
- 📱 Easy integration

Coming Soon:
- Google Gemini Integration
- Claude AI Integration
- Voice Recognition
- Text-to-Speech
- Custom UI Components
- Message Storage
- And more!

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ai_chat_plus: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage

Here's a simple example of how to use the AI Chat Plus package with OpenAI:

```dart
import 'package:ai_chat_plus/ai_chat_plus.dart';

// Initialize with OpenAI
final config = AIModelConfig(
  provider: AIProvider.openAI,
  apiKey: "YOUR_OPENAI_API_KEY",
  modelId: OpenAIModel.gpt4.modelId,
);

// Create and initialize the service
final aiService = AIServiceFactory.createService(AIProvider.openAI);
await aiService.initialize(config);

// Generate a response
final response = await aiService.generateResponse("Hello, how are you?");
print(response);

// Or use streaming for real-time responses
aiService.streamResponse("Tell me a story").listen(
  (chunk) => print(chunk),
  onDone: () => print("Story complete!"),
);
```

## Additional Information

- **Contributing**: We welcome contributions! Please read our contributing guidelines before submitting pull requests.
- **Issues**: File issues at the [GitHub repository](https://github.com/jamalihassan0307/ai_chat_plus/issues)
- **License**: This project is licensed under the MIT License - see the LICENSE file for details

## Support

If you find this package helpful, please give it a star on [GitHub](https://github.com/jamalihassan0307/ai_chat_plus)!
