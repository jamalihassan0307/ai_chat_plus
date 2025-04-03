import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ai_service.dart';
import '../models/ai_model.dart';

class GeminiService implements AIService {
  String? _apiKey;
  late final String _baseUrl;
  late final String _model;

  GeminiService({required String apiKey}) {
    _apiKey = apiKey;
  }

  @override
  Future<void> initialize(AIModelConfig config) async {
    if (config.provider != AIProvider.gemini) {
      throw ArgumentError('Invalid provider type for GeminiService');
    }
    _apiKey = config.apiKey;
    _model = config.modelId ?? GeminiModel.geminiFlash.modelId;
    _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent';
  }

  @override
  Future<String> generateResponse(String prompt) async {
    if (_apiKey == null) {
      throw StateError('GeminiService not initialized. Call initialize() first.');
    }

    final url = Uri.parse('$_baseUrl?key=$_apiKey');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{
            "parts": [{"text": prompt}]
          }]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        return text ?? 'No response generated';
      } else {
        throw Exception('Failed to generate response: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      throw Exception('Gemini Error: $e');
    }
  }

  @override
  Stream<String> streamResponse(String prompt) async* {
    // Currently, Gemini 1.5 Flash doesn't support streaming
    // Return the response as a single chunk
    final response = await generateResponse(prompt);
    yield response;
  }

  @override
  Future<void> dispose() async {
    // No cleanup needed for Gemini
  }
} 