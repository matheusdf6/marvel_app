import 'dart:convert';

import 'package:marvel_app/core/local_storage/hive/hive_storage.dart';
import 'package:marvel_app/core/local_storage/local_memory_management.dart';
import 'package:marvel_app/core/errors/exceptions.dart';
import 'package:marvel_app/data/models/comic_model.dart';

class ComicLocalDataSource implements LocalMemoryManagement<ComicModel> {
  final HiveStorage storage;
  final comicBox = 'comicBox';
  final characterComicsBox = 'characterComicsBox';

  ComicLocalDataSource({
    required this.storage,
  });

  Future<void> storeCharacterComics(int characterId, List<ComicModel> comics) async {
    final comicIds = comics.map((comic) => comic.id).toList();
    await storage.store(
      characterComicsBox,
      characterId.toString(),
      minutesForExpiring,
      json.encode(comicIds),
    );
    final entries = comics.map((comic) => MapEntry(
          comic.id.toString(),
          ComicModel.toJson(comic),
        ));
    final mapped = Map<String, String>.fromIterable(entries);
    await storage.storeMany(comicBox, minutesForExpiring, mapped);
  }

  Future<bool> containsValidCharacterComics(int characterId) =>
      storage.containValidKey(characterComicsBox, characterId.toString());

  Future<List<ComicModel>> getStoredCharacterComics(int characterId) async {
    final serialized = await storage.get(characterComicsBox, characterId.toString());
    final comidIds = List<String>.from(json.decode(serialized));
    final comicsSerialized = await storage.getMany(comicBox, comidIds);
    return comicsSerialized.map((comic) => ComicModel.fromLocalJson(json.decode(comic))).toList();
  }

  @override
  Future<bool> containsValid(String key) => storage.containValidKey(comicBox, key);

  @override
  Future<ComicModel> getStored(String key) async {
    final stored = await storage.get(comicBox, key);
    if (stored.isNotEmpty) {
      return ComicModel.fromLocalJson(json.decode(stored));
    }
    throw LocalStorageException();
  }

  @override
  int get minutesForExpiring => 1440; // one day

  @override
  Future<void> store(String key, ComicModel object) =>
      storage.store(comicBox, key, minutesForExpiring, ComicModel.toJson(object));
}
