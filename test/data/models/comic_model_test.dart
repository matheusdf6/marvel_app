import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/data/models/comic_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const testJson = '{"id":99460,"title":"Spider-Gwen Infinity Comic Primer (2021) #1","thumbnail":"http://i.annihil.us/u/prod/marvel/i/mg/1/b0/613ac5ddabfe1.jpg"}';
  const testComic = ComicModel(
    id: 99460,
    title: 'Spider-Gwen Infinity Comic Primer (2021) #1',
    thumbnail: 'http://i.annihil.us/u/prod/marvel/i/mg/1/b0/613ac5ddabfe1.jpg',
  );
  test('should create a model from remote json when correctly', () async {
    // Arrange
    final jsonString = fixture('character_comics.json');
    final mapped = json.decode(jsonString);
    // Act
    final result = ComicModel.fromRemoteJson(mapped['data']['results'][0]);
    // Assert
    expect(result, testComic);
  });

  test('should create a model from local json when correctly', () async {
    // Arrange
    final jsonString = fixture('character_comics_local.json');
    final mapped = json.decode(jsonString);
    // Act
    final result = ComicModel.fromLocalJson(mapped);
    // Assert
    expect(result, testComic);
  });

  test('should create a json correctly', () async {
    // Act
    final result = ComicModel.toJson(testComic);
    // Assert
    expect(result, testJson);
  });
}
