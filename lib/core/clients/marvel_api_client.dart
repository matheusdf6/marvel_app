import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarvelApiClient {
  final String baseurl = 'http://gateway.marvel.com/v1/public';
  String _publicKey = '';
  String _privateKey = '';
  http.Client client;

  MarvelApiClient({
    required String public,
    required String private,
    required this.client,
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

  Uri generateUrl(String path) {
    final timestamp = generateTimestamp();
    final hash = generateHash(timestamp);
    return Uri.parse('$baseurl$path?ts=$timestamp&apikey=$_publicKey&hash=$hash');
  }

  Future<Map<String, dynamic>> get(String path) async {
    final url = generateUrl(path);
    final response = await client.get(url);
    return json.decode(response.body);
  }
}
