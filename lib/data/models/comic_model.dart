import 'dart:convert';

import 'package:marvel_app/domain/entities/comic.dart';

class ComicModel extends Comic {
  const ComicModel({
    required int id,
    required String title,
    required String thumbnail,
  }) : super(
    id: id,
    title: title,
    thumbnail: thumbnail
  );

  factory ComicModel.fromRemoteJson(Map<String,dynamic> map) {
    final path = map['thumbnail']['path'] as String;
    final extension = map['thumbnail']['extension'] as String;

    return ComicModel(
      id: map['id'], 
      title: map['title'], 
      thumbnail: '$path.$extension'
    );
  }

  factory ComicModel.fromLocalJson(Map<String,dynamic> map) => 
    ComicModel(
      id: map['id'], 
      title: map['title'], 
      thumbnail: map['thumbnail']
    );

  static String toJson(ComicModel model) => 
    json.encode({
      'id': model.id,
      'title': model.title,
      'thumbnail': model.thumbnail,
    });

}