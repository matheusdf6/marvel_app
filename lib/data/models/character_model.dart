import 'package:marvel_app/domain/entities/Character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required int id,
    required String name,
    required String description,
    required String thumbnail,
    required List<String> comics,
  }) : super(
          id: id,
          name: name,
          description: description,
          thumbnail: thumbnail,
          comics: comics,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> map) {
    final path = map['thumbnail']['path'] as String;
    final extension = map['thumbnail']['extension'] as String;

    return CharacterModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      thumbnail: '$path.$extension',
      comics: List<String>.from(map['comics']['items']),
    );
  }
}
