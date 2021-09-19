import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:marvel_app/core/errors/exceptions.dart';
import 'package:marvel_app/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/data/models/character_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'character_remote_data_source_test.mocks.dart';

@GenerateMocks([MarvelApiClient])
void main() {
  late MockMarvelApiClient mockClient;
  late CharacterRemoteDataSource datasource;
  final testCharacterList = [
    CharacterModel(
      id: 1011334,
      name: '3-D Man',
      description: '',
      thumbnail: 'http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg',
      comics: ['Avengers: The Initiative (2007) #14'],
    ),
  ];
  final testCharacter = CharacterModel(
    id: 1,
    name: 'Teste',
    description: 'Descrição teste',
    thumbnail: 'http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg',
    comics: ['Avengers: The Initiative (2007) #14'],
  );

  setUp(() {
    mockClient = MockMarvelApiClient();
    datasource = CharacterRemoteDataSource(mockClient);
  });

  void mockCharacterListCorrect() {
    when(mockClient.get(any)).thenAnswer((_) async {
      final mapped = json.decode(fixture('characters.json'));
      return Future.value(mapped);
    });
  }

  void mockCharacterCorrect() {
    when(mockClient.get(any)).thenAnswer((_) async {
      final mapped = json.decode(fixture('character.json'));
      return Future.value(mapped);
    });
  }

  void mockCharacteNotFound() {
    when(mockClient.get(any)).thenAnswer((_) async {
      final mapped = json.decode(fixture('character_not_found.json'));
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
    test('should return list of Character', () async {
      // Arrange
      mockCharacterListCorrect();
      // Act
      final result = await datasource.index(0);
      // Assert
      verify(mockClient.get('/characters?offset=0'));
      expect(result, equals(testCharacterList));
    });

    test('should throw ServerException when any code is returned from remote', () async {
      // Arrange
      mockError();
      // Assert
      expect(() => datasource.index(0), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('show', () {
    test('should return character of the corresponding id', () async {
      // Arrange
      mockCharacterCorrect();
      // Act
      final result = await datasource.show(1);
      // Assert
      verify(mockClient.get('/characters/1'));
      expect(result, equals(testCharacter));
    });

    test('should throw NotFoundException when id is not found', () async {
      // Arrange
      mockCharacteNotFound();
      // Assert
      expect(() => datasource.show(9999), throwsA(TypeMatcher<NotFoundException>()));
    });

    test('should throw ServerException when any code is returned from remote', () async {
      // Arrange
      mockError();
      // Assert
      expect(() => datasource.show(9999), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
