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
  ai_chat_plus: ^1.0.2
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
  modelId: OpenAIModel.gpt35Turbo.modelId, // or gpt4, gpt4Turbo
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
  provider: AIProvider.gemini,
  apiKey: "YOUR_GEMINI_API_KEY",
  modelId: GeminiModel.geminiFlash.modelId, // or geminiPro, geminiPro15
);

// Create and initialize the service
final aiService = AIServiceFactory.createService(AIProvider.gemini);
await aiService.initialize(config);

// Generate a response
final response = await aiService.generateResponse("What is quantum computing?");
print(response);

// Note: Streaming is not yet supported for Gemini Flash model
```

### Complete Flutter Example

Here's a complete example showing how to create a chat application with support for both OpenAI and Gemini:

```dart
import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  late final AIService _aiService;
  bool _isLoading = false;
  String? _error;
  AIProvider _currentProvider = AIProvider.gemini;

  @override
  void initState() {
    super.initState();
    _initAI();
  }

  Future<void> _initAI() async {
    try {
      final config = AIModelConfig(
        provider: _currentProvider,
        apiKey: _currentProvider == AIProvider.openAI
            ? "YOUR_OPENAI_API_KEY"
            : "YOUR_GEMINI_API_KEY",
        modelId: _currentProvider == AIProvider.openAI
            ? OpenAIModel.gpt35Turbo.modelId
            : GeminiModel.geminiFlash.modelId,
      );

      _aiService = AIServiceFactory.createService(_currentProvider);
      await _aiService.initialize(config);
      setState(() => _error = null);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  void _switchProvider() {
    setState(() {
      _currentProvider = _currentProvider == AIProvider.openAI
          ? AIProvider.gemini
          : AIProvider.openAI;
      _initAI();
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final message = _controller.text;
    setState(() {
      _messages.add('You: $message');
      _isLoading = true;
      _error = null;
    });
    _controller.clear();

    try {
      final response = await _aiService.generateResponse(message);
      setState(() {
        _messages.add('${_currentProvider == AIProvider.openAI ? "OpenAI" : "Gemini"}: $response');
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _aiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_currentProvider == AIProvider.openAI ? "OpenAI" : "Gemini"} Chat'),
        actions: [
          IconButton(
            icon: Icon(_currentProvider == AIProvider.openAI
                ? Icons.psychology
                : Icons.chat_bubble),
            onPressed: _switchProvider,
            tooltip: 'Switch to ${_currentProvider == AIProvider.openAI ? "Gemini" : "OpenAI"}',
          ),
        ],
      ),
      body: Column(
        children: [
          if (_error != null)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red.shade100,
              child: Text(
                'Error: $_error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.startsWith('You: ');
                
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.blue.shade100
                          : (_currentProvider == AIProvider.openAI
                              ? Colors.grey.shade200
                              : Colors.deepPurple.shade50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask ${_currentProvider == AIProvider.openAI ? "OpenAI" : "Gemini"} something...',
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
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

### Key Features

1. **Provider Selection**
   - Switch between OpenAI and Gemini providers
   - Each provider uses its specific model configuration

2. **Error Handling**
   - Proper initialization error handling
   - Message sending error handling
   - Visual error feedback

3. **UI Features**
   - Beautiful message bubbles
   - Different colors for user and AI messages
   - Loading indicators
   - Provider-specific styling

4. **Service Management**
   - Proper service initialization
   - Resource cleanup on dispose
   - API key configuration

### Important Notes

1. **API Keys**
   - Replace `YOUR_OPENAI_API_KEY` with your actual OpenAI API key
   - Replace `YOUR_GEMINI_API_KEY` with your actual Gemini API key
   - Never commit API keys to version control

2. **Model Selection**
   - OpenAI models: `gpt35Turbo`, `gpt4`, `gpt4Turbo`
   - Gemini models: `geminiFlash`, `geminiPro`, `geminiPro15`

3. **Streaming Support**
   - OpenAI supports streaming responses
   - Gemini Flash currently doesn't support streaming

4. **Error Handling**
   - Always wrap service calls in try-catch blocks
   - Handle initialization errors
   - Provide user feedback for errors

## Additional Information

- **API Keys**: You'll need to obtain API keys from:
  - OpenAI: [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
  - Google AI Studio: [https://makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)

- **Contributing**: We welcome contributions! Please read our contributing guidelines before submitting pull requests.
- **Issues**: File issues at the [GitHub repository](https://github.com/jamalihassan0307/ai_chat_plus/issues)
- **License**: This project is licensed under the MIT License - see the LICENSE file for details

## Support

If you find this package helpful, please give it a star on [GitHub](https://github.com/jamalihassan0307/ai_chat_plus)!
