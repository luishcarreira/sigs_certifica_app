import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;
  final String baseUrl;

  ApiService({required this.client, this.baseUrl = 'http://10.0.2.2:8000'});

  Future<Map<String, dynamic>?> getToken(
      String url, Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$baseUrl$url');
      final response = await client.post(
        uri,
        body: data,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>?;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception during POST request: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final uri =
          Uri.parse('$baseUrl$url').replace(queryParameters: queryParameters);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>?;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception during GET request: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> post(
      String url, Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$baseUrl$url');
      final response = await client.post(uri, body: jsonEncode(data), headers: {
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>?;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception during POST request: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> put(
      String url, Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$baseUrl$url');
      final response = await client.put(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>?;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception during PUT request: $e');
      return null;
    }
  }

  Future<bool> delete(String url) async {
    try {
      final uri = Uri.parse('$baseUrl$url');
      final response = await client.delete(uri);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception during DELETE request: $e');
      return false;
    }
  }
}
