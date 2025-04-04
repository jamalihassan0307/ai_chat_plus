# AI Chat Plus Example

This example demonstrates how to use the AI Chat Plus package created by jamalihassan0307.

## Features Demonstrated

- Multiple AI provider support (OpenAI, Gemini, Claude)
- Real-time provider switching
- Error handling
- Type-safe implementation

## Getting Started

1. Clone the repository
2. Add your API keys in `lib/main.dart`:
   ```dart
   String _getApiKey(AIProvider provider) {
     switch (provider) {
       case AIProvider.openAI:
         return 'YOUR_OPENAI_API_KEY';
       case AIProvider.gemini:
         return 'YOUR_GEMINI_API_KEY';
       case AIProvider.claude:
         return 'YOUR_CLAUDE_API_KEY';
     }
   }
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Usage

The example shows:
- How to initialize the AI Chat widget
- How to switch between different AI providers
- How to handle errors
- How to customize the chat interface

For more details, check the [package documentation](https://pub.dev/packages/ai_chat_plus).