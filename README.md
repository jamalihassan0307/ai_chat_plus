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
- 🧠 Google Gemini Integration
- 🔄 Streaming responses support
- 🎯 Type-safe API
- 📱 Easy integration with beautiful UI components
- ⚡ Fast and efficient message handling

Coming Soon:
- Claude AI Integration
- Voice Recognition
- Text-to-Speech
- Message Storage
- And more!

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ai_chat_plus: ^1.0.1
```

Then run:
```bash
flutter pub get
```

## Usage

### Basic Usage with OpenAI

```dart
import 'package:ai_chat_plus/ai_chat_plus.dart';

// Initialize with OpenAI
final config = AIModelConfig(
  provider: AIProvider.openAI,
  apiKey: "YOUR_OPENAI_API_KEY",
  modelId: OpenAIModel.gpt35Turbo.modelId,
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

### Using with Google Gemini

```dart
import 'package:ai_chat_plus/ai_chat_plus.dart';

// Initialize with Gemini
final config = AIModelConfig(
  provider: AIProvider.googleGemini,
  apiKey: "YOUR_GEMINI_API_KEY",
  modelId: GeminiModel.geminiPro.modelId,
);

final aiService = AIServiceFactory.createService(AIProvider.googleGemini);
await aiService.initialize(config);

// Generate a response
final response = await aiService.generateResponse("What is quantum computing?");
print(response);
```

### Flutter UI Integration Example

Here's a simple example of how to integrate the chat functionality into a Flutter UI:

```dart
class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  late final AIService _aiService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initAI();
  }

  Future<void> _initAI() async {
    final config = AIModelConfig(
      provider: AIProvider.openAI,
      apiKey: "YOUR_API_KEY",
      modelId: OpenAIModel.gpt35Turbo.modelId,
    );
    _aiService = AIServiceFactory.createService(AIProvider.openAI);
    await _aiService.initialize(config);
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add('You: ${_controller.text}');
      _isLoading = true;
    });

    final response = await _aiService.generateResponse(_controller.text);
    
    setState(() {
      _messages.add('AI: $response');
      _isLoading = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          if (_isLoading) CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Additional Information

- **API Keys**: You'll need to obtain API keys from:
  - OpenAI: [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
  - Google AI Studio: [https://makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)

- **Contributing**: We welcome contributions! Please read our contributing guidelines before submitting pull requests.
- **Issues**: File issues at the [GitHub repository](https://github.com/jamalihassan0307/ai_chat_plus/issues)
- **License**: This project is licensed under the MIT License - see the LICENSE file for details

## Support

If you find this package helpful, please give it a star on [GitHub](https://github.com/jamalihassan0307/ai_chat_plus)!
