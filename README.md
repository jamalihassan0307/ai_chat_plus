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
<div align="center">
  <kbd>
    <img src="https://github.com/jamalihassan0307/ai_chat_plus/blob/main/image/image.jpg?raw=true" width="250" alt="Jam Ali Hassan"/>
  </kbd>
  
  <h1>🌟 AI Chat Plus 🌟</h1>
  <p><i>A powerful Flutter package for AI chat integration with OpenAI, Google Gemini, and Claude AI</i></p>
  
  <p align="center">
    <a href="https://github.com/jamalihassan0307">
      <img src="https://img.shields.io/badge/Created_by-Jam_Ali_Hassan-blue?style=for-the-badge&logo=github&logoColor=white" alt="Created by"/>
    </a>
  </p>

  <p align="center">
    <a href="https://github.com/jamalihassan0307">
      <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
    </a>
    <a href="https://www.linkedin.com/in/jamalihassan0307">
      <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
    </a>
    <a href="https://jamalihassan0307.github.io/portfolio.github.io">
      <img src="https://img.shields.io/badge/Portfolio-255E63?style=for-the-badge&logo=About.me&logoColor=white" alt="Portfolio"/>
    </a>
  </p>

  <p align="center">
    <a href="https://pub.dev/packages/ai_chat_plus">
      <img src="https://img.shields.io/pub/v/ai_chat_plus?style=for-the-badge&logo=dart&logoColor=white" alt="Pub Version"/>
    </a>
    <a href="https://flutter.dev">
      <img src="https://img.shields.io/badge/Platform-Flutter-02569B?style=for-the-badge&logo=flutter" alt="Platform"/>
    </a>
    <a href="https://opensource.org/licenses/MIT">
      <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License: MIT"/>
    </a>
  </p>

  <p align="center">
    <a href="https://pub.dev/packages/ai_chat_plus">
      <img src="https://img.shields.io/pub/likes/ai_chat_plus?style=for-the-badge&logo=flutter&logoColor=white&label=Pub%20Likes" alt="Pub Likes"/>
    </a>
    <a href="https://pub.dev/packages/ai_chat_plus">
      <img src="https://img.shields.io/pub/points/ai_chat_plus?style=for-the-badge&logo=flutter&logoColor=white&label=Pub%20Points" alt="Pub Points"/>
    </a>
    <a href="https://pub.dev/packages/ai_chat_plus">
      <img src="https://img.shields.io/pub/popularity/ai_chat_plus?style=for-the-badge&logo=flutter&logoColor=white&label=Popularity" alt="Popularity"/>
    </a>
  </p>
</div>

---

# AI Chat Plus

> 🌟 Experience the future of chat interfaces with AI Chat Plus - where intelligent chat meets modern design. Featuring seamless AI integration, real-time interactions, and multiple provider support. Built with Flutter, powered by cutting-edge AI.

## ✨ Crafted by Jamalihassan0307

Transform your chat experience with:
- ⚡ Real-time AI interactions with typing indicators
- 🤖 Multiple AI providers (OpenAI, Gemini, Claude)
- 🔄 Seamless provider switching
- 📱 Clean and efficient message handling
- ✨ Type-safe API implementation
- 🛡️ Robust error handling

### 👨‍💻 Developer Contact
- **Creator**: [Jam Ali Hassan](https://github.com/jamalihassan0307)
- **Portfolio**: [View Portfolio](https://jamalihassan0307.github.io/portfolio.github.io)
- **Email**: jamalihassan0307@gmail.com
- **LinkedIn**: [Connect on LinkedIn](https://www.linkedin.com/in/jamalihassan0307)

## Key Features

### 1. AI Integration – Multiple Provider Support

```dart
// Initialize OpenAI
final openAIConfig = AIModelConfig(
  provider: AIProvider.openAI,
  apiKey: 'YOUR_OPENAI_API_KEY',
  modelId: OpenAIModel.gpt35Turbo.modelId,
);

// Initialize Gemini
final geminiConfig = AIModelConfig(
  provider: AIProvider.gemini,
  apiKey: 'YOUR_GEMINI_API_KEY',
  modelId: GeminiModel.geminiFlash.modelId,
);

// Initialize Claude
final claudeConfig = AIModelConfig(
  provider: AIProvider.claude,
  apiKey: 'YOUR_CLAUDE_API_KEY',
  modelId: ClaudeModel.claude3Sonnet.modelId,
);
```

### 2. Efficient Message Handling

```dart
AIChat(
  apiKey: 'YOUR_API_KEY',
  provider: AIProvider.gemini,
  modelId: GeminiModel.geminiFlash.modelId,
  onError: (error) {
    print('Error: $error');
  },
)
```

### 3. Type-Safe Implementation

```dart
CustomChatUI(
  messages: messages,
  onSendMessage: handleMessage,
  isTyping: isTyping,
  onError: handleError,
)
```

For detailed examples and implementation, check:
- Basic Usage: `example/lib/main.dart`
- AI Integration: `example/ai_integration/`
- Error Handling: `example/error_handling/`

## Features

Currently Implemented:
- 🤖 OpenAI GPT Integration (3.5/4.4-turbo)
- 🧠 Google Gemini Integration
- 🔄 Streaming responses support
- 🎯 Type-safe API
- ⚡ Fast and efficient message handling
- 🔄 Real-time provider switching
- ⌨️ Typing indicators
- 🚨 Enhanced error handling

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
  ai_chat_plus: ^1.2.0
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

### Using Prebuilt Chat UI (New in 1.0.8)

For quick implementation, you can use our new prebuilt chat UI:

```dart
AIChat(
  apiKey: 'YOUR_API_KEY',
  provider: AIProvider.gemini,
  modelId: GeminiModel.geminiFlash.modelId,
  primaryColor: Theme.of(context).primaryColor,
  backgroundColor: Colors.grey[100],
  // Optional customization
  onProviderChanged: (AIProvider newProvider) {
    // Handle provider change
    return AIModelConfig(
      provider: newProvider,
      apiKey: getApiKeyForProvider(newProvider),
      modelId: getDefaultModelForProvider(newProvider),
    );
  },
  onError: (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.toString())),
    );
  },
)
```

Key features of the prebuilt UI:
- Built-in provider switching (OpenAI, Gemini, Claude)
- Customizable themes and styles
- Error handling and loading states
- Message bubble customization
- Input field customization

For detailed customization options, check the example folder in the package repository.

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

## Contact

- 👨‍💻 Developed by [Jam Ali Hassan](https://github.com/jamalihassan0307)
- 🌐 [Portfolio](https://jamalihassan0307.github.io/portfolio.github.io)
- 📧 Email: jamalihassan0307@gmail.com
- 🔗 [LinkedIn](https://www.linkedin.com/in/jamalihassan0307)
