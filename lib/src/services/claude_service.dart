import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ai_service.dart';
import '../models/ai_model.dart';

class ClaudeService implements AIService {
  String? _apiKey;
  late final String _model;
  final String _baseUrl = 'https://api.anthropic.com/v1/messages';
  final String _apiVersion = '2023-06-01';

  ClaudeService({required String apiKey}) {
    _apiKey = apiKey;
  }

  @override
  Future<void> initialize(AIModelConfig config) async {
    if (config.provider != AIProvider.claude) {
      throw ArgumentError('Invalid provider type for ClaudeService');
    }
    _apiKey = config.apiKey;
    _model = config.modelId ?? ClaudeModel.claude3Sonnet.modelId;
  }

  @override
  Future<String> generateResponse(String prompt) async {
    if (_apiKey == null) {
      throw StateError(
          'ClaudeService not initialized. Call initialize() first.');
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'x-api-key': _apiKey!,
          'anthropic-version': _apiVersion,
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': _model,
          'max_tokens': 1024,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['content'][0]['text'] ?? 'No response generated';
      } else {
        throw Exception(
            'Failed to generate response: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      throw Exception('Claude Error: $e');
    }
  }

  @override
  Stream<String> streamResponse(String prompt) async* {
    // Currently implementing non-streaming response
    // TODO: Implement streaming when available
    final response = await generateResponse(prompt);
    yield response;
  }

  @override
  Future<void> dispose() async {
    // No cleanup needed for Claude
  }
}
