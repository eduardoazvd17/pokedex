import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/data/exceptions/app_exception.dart';

mixin AppRepository {
  Future<Map<String, dynamic>> get({
    required String url,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      throw AppException(
        'connection-error'.i18n(),
        detailedMessage: error.toString(),
      );
    }
  }
}
