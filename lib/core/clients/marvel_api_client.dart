import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarvelApiClient {
  String baseurl = '';
  String _publicKey = '';
  String _privateKey = '';
  http.Client client;

  MarvelApiClient({
    required this.baseurl,
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

  Digest generateHash(int timestamp) {
    final bytes = utf8.encode('$timestamp$_privateKey$_publicKey');
    return md5.convert(bytes);
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
