import 'dart:convert';

import 'package:http/http.dart' as http;

class AppService {
  Future<Map<String, dynamic>> get({
    required String url,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('');
      }
    } catch (_) {
      rethrow;
    }
  }
}
