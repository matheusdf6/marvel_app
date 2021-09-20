import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'marvel_api_client_test.mocks.dart';
import '../../fixtures/fixture_reader.dart';

@GenerateMocks([http.Client])
void main() async {
  dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());

  late MarvelApiClient apiClient;
  late MockClient httpClient;
  const public = '01234';
  const private = '56789';
  const testTimestamp = 9999999999;
  const testHash = '21295936104e22f306d0159e9040eb34'; // http://www.md5.cz/
  final testData = await fixture('characters.json');
  void setUpMockClientSuccess() {
    when(httpClient.get(any)).thenAnswer((_) async => http.Response(testData, 200));
  }

  setUp(() {
    httpClient = MockClient();
    apiClient = MarvelApiClient(
      public: public,
      private: private,
      client: httpClient,
      baseurl: dotenv.get('MARVEL_API_BASE'),
    );
  });

  test('should generate timestamp of current time', () async {
    // Act
    final result = apiClient.generateTimestamp();
    // Assert
    expect(result, isA<int>());
  });

  test('should generate hash when timestamp is provided', () async {
    // Act
    final result = apiClient.generateHash(testTimestamp);
    // Assert
    expect(result, testHash);
  });

  test('should generate url correcly when path is provided', () async {
    // Act
    final result = apiClient.generateUrl('/teste');
    // Assert
    expect(result.queryParameters, contains('ts'));
    expect(result.queryParameters, contains('apikey'));
    expect(result.queryParameters, contains('hash'));
  });

  test('should create return Map when path is provided', () async {
    // Arrange
    setUpMockClientSuccess();
    // Act
    final result = await apiClient.get('/test');
    // Assert
    expect(result, contains('code'));
    expect(result, containsPair('code', 200));
    expect(result, contains('data'));
  });
}
