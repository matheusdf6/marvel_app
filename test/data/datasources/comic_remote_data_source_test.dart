import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:marvel_app/core/errors/exceptions.dart';
import 'package:marvel_app/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/data/datasources/comic_remote_data_source.dart';
import 'package:marvel_app/data/models/character_model.dart';
import 'package:marvel_app/data/models/comic_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'comic_remote_data_source_test.mocks.dart';

@GenerateMocks([MarvelApiClient])
void main() {
  late MockMarvelApiClient mockClient;
  late ComicRemoteDataSource datasource;
  const testComicList = [
    ComicModel(
      id: 99460,
      title: 'Spider-Gwen Infinity Comic Primer (2021) #1',
      thumbnail: 'http://i.annihil.us/u/prod/marvel/i/mg/1/b0/613ac5ddabfe1.jpg',
    )
  ];

  setUp(() {
    mockClient = MockMarvelApiClient();
    datasource = ComicRemoteDataSource(mockClient);
  });

  void mockComicListCorrect() {
    when(mockClient.get(any)).thenAnswer((_) async {
      final mapped = json.decode(fixture('character_comics.json'));
      return Future.value(mapped);
    });
  }

  void mockError() {
    when(mockClient.get(any)).thenAnswer((_) async {
      return Future.value({
        'code': 400 // any
      });
    });
  }

  group('index', () {
    test('should return list of Comics', () async {
      // Arrange
      mockComicListCorrect();
      // Act
      final result = await datasource.getByCharacter(1);
      // Assert
      verify(mockClient.get('/characters/1/comics'));
      expect(result, equals(testComicList));
    });

    test('should throw ServerException when any code is returned from remote', () async {
      // Arrange
      mockError();
      // Assert
      expect(() => datasource.getByCharacter(0), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
