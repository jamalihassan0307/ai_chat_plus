// import 'dart:async';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:http/http.dart' as http;
import 'src/services/platform_http_client.dart';

class AIChatPlusWeb {
  static void registerWith(Registrar registrar) {
    // Web platform registration logic here
  }
}

// Use PlatformHttpClient for web requests instead of implementing HttpClient
final httpClient = PlatformHttpClient();
