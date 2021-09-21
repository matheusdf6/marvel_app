import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/data/models/character_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const testJson =
      '{"id":1,"name":"Teste","description":"Descrição teste","thumbnail":"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg","comics":["Avengers: The Initiative (2007) #14"]}';
  final testCharacter = CharacterModel(
    id: 1,
    name: 'Teste',
    description: 'Descrição teste',
    thumbnail: 'http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg',
    comics: const ['Avengers: The Initiative (2007) #14'],
  );

  test('should create a model from remote json when correctly', () async {
    // Arrange
    final jsonString = fixture('character.json');
    final mapped = json.decode(jsonString);
    // Act
    final result = CharacterModel.fromRemoteJson(mapped['data']['results'][0]);
    // Assert
    expect(result, testCharacter);
  });

  test('should create a model from local json when correctly', () async {
    // Arrange
    final jsonString = fixture('character_local.json');
    final mapped = json.decode(jsonString);
    // Act
    final result = CharacterModel.fromLocalJson(mapped);
    // Assert
    expect(result, testCharacter);
  });

  test('should create a json correctly', () async {
    // Act
    final result = CharacterModel.toJson(testCharacter);
    // Assert
    expect(result, testJson);
  });
}
