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

A Flutter package that provides AI chat functionality with enhanced features and customization options. This package makes it easy to integrate AI-powered chat capabilities into your Flutter applications.

## Features

- 🤖 Easy integration with AI chat services
- 🎨 Customizable chat UI components
- 💾 Built-in message persistence
- 🔄 State management using Provider
- 🎯 Type-safe API
- 📱 Responsive design
- 🌐 Network handling with retry mechanisms

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ai_chat_plus: ^0.0.1
```

Then run:
```bash
flutter pub get
```

## Usage

Here's a simple example of how to use the AI Chat Plus package:

```dart
import 'package:ai_chat_plus/ai_chat_plus.dart';

// Initialize the chat
final chatController = AIChatController();

// Use in your widget
AIChatWidget(
  controller: chatController,
  theme: AIChatTheme.light(),
  onMessageSent: (message) {
    // Handle message
  },
)
```

For more examples, please see the `/example` directory in the repository.

## Additional information

- **Contributing**: We welcome contributions! Please read our contributing guidelines before submitting pull requests.
- **Issues**: File issues at the [GitHub repository](https://github.com/yourusername/ai_chat_plus/issues)
- **Documentation**: For detailed documentation, visit our [documentation site](https://github.com/yourusername/ai_chat_plus/wiki)
- **License**: This project is licensed under the MIT License - see the LICENSE file for details

## Support

If you find this package helpful, please give it a star on [GitHub](https://github.com/yourusername/ai_chat_plus)!
