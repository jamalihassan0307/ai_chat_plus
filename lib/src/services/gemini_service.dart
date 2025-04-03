import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ai_service.dart';

class GeminiService implements AIService {
  final String apiKey;
  final String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

  GeminiService({required this.apiKey});

  @override
  Future<String> generateResponse(String prompt) async {
    final url = Uri.parse('$_baseUrl?key=$apiKey');

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