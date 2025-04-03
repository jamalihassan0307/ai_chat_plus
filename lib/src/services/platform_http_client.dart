import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:universal_io/io.dart';

class PlatformHttpClient {
  final http.Client _client = http.Client();

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return _client.get(url, headers: headers);
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _client.post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  void close() {
    _client.close();
  }

  // Add other necessary HTTP methods as needed
}
