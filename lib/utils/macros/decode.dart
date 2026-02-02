import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onemovies/models/decode.dart';

const String API_BASE = 'https://enc-dec.app/api';

Future<DecodeResult> decode(String n) async {
  final response = await http.post(
    Uri.parse('$API_BASE/dec-mega'),
    headers: {
      'Content-Type': 'application/json',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36',
    },
    body: jsonEncode({
      'text': n,
      'agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36',
    }),
  );

  if (response.statusCode != 200) {
    throw Exception(
      'Decode failed: ${response.statusCode} ${response.body}',
    );
  }

  final decoded = jsonDecode(response.body);

  if (decoded is! Map<String, dynamic>) {
    throw Exception('Invalid decode response shape');
  }

  final result = decoded['result'];

  if (result == null || result is! Map<String, dynamic>) {
    throw Exception('Decode result is null or invalid: $decoded');
  }

  return DecodeResult.fromJson(result);
}

