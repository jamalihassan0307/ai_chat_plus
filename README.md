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

## Usage

### Basic Setup

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ai_chat_plus: ^1.0.8
```

Then run:
```bash
flutter pub get
```

### Using OpenAI Service

```dart
import 'package:ai_chat_plus/ai_chat_plus.dart';

Future<void> initOpenAI() async {
  final config = AIModelConfig(
    provider: AIProvider.openAI,
    apiKey: 'YOUR_OPENAI_API_KEY',
    modelId: OpenAIModel.gpt35Turbo.modelId,
  );

  final aiService = AIServiceFactory.createService(AIProvider.openAI);
  await aiService.initialize(config);
  
  // Generate response
  final response = await aiService.generateResponse("Hello, how are you?");
  print(response);
}
```

### Using Gemini Service

```dart
import 'package:ai_chat_plus/ai_chat_plus.dart';

Future<void> initGemini() async {
  final config = AIModelConfig(
    provider: AIProvider.gemini,
    apiKey: 'YOUR_GEMINI_API_KEY',
    modelId: GeminiModel.geminiFlash.modelId,
  );

  final aiService = AIServiceFactory.createService(AIProvider.gemini);
  await aiService.initialize(config);
  
  // Generate response
  final response = await aiService.generateResponse("What is quantum computing?");
  print(response);
}
```

### Using Claude Service

```dart
import 'package:ai_chat_plus/ai_chat_plus.dart';

Future<void> initClaude() async {
  final config = AIModelConfig(
    provider: AIProvider.claude,
    apiKey: 'YOUR_CLAUDE_API_KEY',
    modelId: ClaudeModel.claude3Sonnet.modelId,
  );

  final aiService = AIServiceFactory.createService(AIProvider.claude);
  await aiService.initialize(config);
  
  // Generate response
  final response = await aiService.generateResponse("What is artificial intelligence?");
  print(response);
}
```

### Creating a Chat Application

To create a chat application with both OpenAI and Gemini support:

1. Create separate pages for each service:
```dart
// Create OpenAI chat page
class OpenAIChatPage extends StatefulWidget {
  // ... implementation in example/pages/openai_page.dart
}

// Create Gemini chat page
class GeminiChatPage extends StatefulWidget {
  // ... implementation in example/pages/gemini_page.dart
}
```

2. Set up navigation between services:
```dart
class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const GeminiChatPage(),
    const OpenAIChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Gemini',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'OpenAI',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
```

### Important Notes

1. **API Keys**: 
   - OpenAI API key: Get from [OpenAI Platform](https://platform.openai.com/api-keys)
   - Gemini API key: Get from [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Claude API key: Get from [Claude AI Platform](https://docs.anthropic.com/en/api/getting-started)

2. **Available Models**:
   - OpenAI: `gpt35Turbo`, `gpt4`, `gpt4Turbo`
   - Gemini: `geminiFlash`, `geminiPro`, `geminiPro15`
   - Claude: `claude3Sonnet`, `claude3Opus`, `claude3Haiku`

3. **Error Handling**:
   ```dart
   try {
     final response = await aiService.generateResponse(message);
     // Handle success
   } catch (e) {
     // Handle error
     print('Error: $e');
   }
   ```

4. **Service Cleanup**:
   ```dart
   @override
   void dispose() {
     aiService.dispose();
     super.dispose();
   }
   ```

For complete implementation examples, check the example folder in the package repository.

### Key Features

1. **Provider Selection**
   - Switch between OpenAI, Gemini, and Claude providers
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
   - Replace `YOUR_CLAUDE_API_KEY` with your actual Claude API key
   - Never commit API keys to version control

2. **Model Selection**
   - OpenAI models: `gpt35Turbo`, `gpt4`, `gpt4Turbo`
   - Gemini models: `geminiFlash`, `geminiPro`, `geminiPro15`
   - Claude models: `claude3Sonnet`, `claude3Opus`, `claude3Haiku`

3. **Streaming Support**
   - OpenAI supports streaming responses
   - Gemini Flash currently doesn't support streaming

4. **Error Handling**
   - Always wrap service calls in try-catch blocks
   - Handle initialization errors
   - Provide user feedback for errors

## Additional Information


- **Contributing**: We welcome contributions! Please read our contributing guidelines before submitting pull requests.
- **Issues**: File issues at the [GitHub repository](https://github.com/jamalihassan0307/ai_chat_plus/issues)
- **License**: This project is licensed under the MIT License - see the LICENSE file for details

## Support

If you find this package helpful, please give it a star on [GitHub](https://github.com/jamalihassan0307/ai_chat_plus)!
