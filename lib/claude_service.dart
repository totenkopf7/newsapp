import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeService {
  // Use the correct endpoint for news
  static const String _apiUrl = 'https://medsnap-7gvx.onrender.com/get_news';

  // Language mapping
  static const Map<String, String> _languageCodes = {
    'English': 'en',
    'Arabic': 'ar',
    'Kurdish': 'ku', // Sorani Kurdish
  };

  Future<String> getNews({
    required String country,
    required String language,
    required String topic,
  }) async {
    try {
      print('=== Fetching News ===');
      print('Country: $country');
      print('Language: $language');
      print('Topic: $topic');

      final String languageCode = _languageCodes[language] ?? 'en';
      final bool needsTranslation = language != 'English';

      print('Making API request to: $_apiUrl');

      final response = await http
          .post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'country': country,
          'topic': topic,
          'original_language': languageCode,
          'needs_translation': needsTranslation,
        }),
      )
          .timeout(
        const Duration(seconds: 120),
        onTimeout: () {
          throw Exception('Request timed out after 120 seconds');
        },
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('error')) {
          throw Exception('Server error: ${data['error']}');
        }

        // Return translated content if available
        if (data['translated_description'] != null) {
          print('✓ Received translated news in $language');
          return data['translated_description'];
        }

        // Fallback to English
        if (data['description'] != null) {
          print('✓ Received news in English');
          return data['description'];
        }

        throw Exception('No news content in response');
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getNews: $e');
      rethrow;
    }
  }
}
