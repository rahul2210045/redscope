// unsplash_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class UnsplashService {
  static const String _baseUrl = 'https://api.unsplash.com';
  final String apiKey;

  UnsplashService(this.apiKey);

  Future<List<dynamic>> fetchImages(int page, int perPage) async {
    final url = Uri.parse('$_baseUrl/photos?client_id=$apiKey&page=$page&per_page=$perPage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load images');
    }
  }
}
