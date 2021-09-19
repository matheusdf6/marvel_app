import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarvelApiClient {
  final String baseurl = 'http://gateway.marvel.com/v1/public';
  String _publicKey = '';
  String _privateKey = '';

  MarvelApiClient({
    required String public,
    required String private,
  }) {
    _publicKey = public;
    _privateKey = private;
  }

  int generateTimestamp() {
    return DateTime.now().microsecondsSinceEpoch;
  }

  String generateHash(int timestamp) {
    final bytes = utf8.encode('$timestamp$_publicKey$_privateKey');
    final hash = md5.convert(bytes);
    return hash.toString();
  }

  @override
  Future<Map<String, dynamic>> get(String url) async {
    final timestamp = generateTimestamp();
    final hash = generateHash(timestamp);
    final response =
        await http.get(Uri.parse('$baseurl$url?ts=$timestamp&apikey=$_publicKey&hash=$hash'));
    return json.decode(response.body);
  }
}
