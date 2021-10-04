import 'dart:convert';

import 'package:marvel_app/domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required int id,
    required String name,
    required String description,
    required String thumbnail,
  }) : super(
          id: id,
          name: name,
          description: description,
          thumbnail: thumbnail,
        );

  factory CharacterModel.fromRemoteJson(Map<String, dynamic> map) {
    final path = map['thumbnail']['path'] as String;
    final extension = map['thumbnail']['extension'] as String;

    return CharacterModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      thumbnail: '$path.$extension',
    );
  }

  factory CharacterModel.fromLocalJson(Map<String, dynamic> map) => CharacterModel(
        id: map['id'] as int,
        name: map['name'] as String,
        description: map['description'] as String,
        thumbnail: map['thumbnail'] as String,
      );

  static String toJson(CharacterModel model) => json.encode({
        'id': model.id,
        'name': model.name,
        'description': model.description,
        'thumbnail': model.thumbnail,
      });
}
