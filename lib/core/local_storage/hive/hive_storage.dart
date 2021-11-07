import 'package:hive/hive.dart';
import 'package:marvel_app/core/local_storage/hive/hive_model.dart';
import 'package:marvel_app/core/errors/exceptions.dart';

class HiveStorage {
  HiveStorage() {
    Hive.registerAdapter(HiveModelAdapter());
  }

  Future<void> store(String boxName, String key, int expireMinutes, String serialized) async {
    final box = await Hive.openBox<HiveModel>(boxName);
    final model = HiveModel(
      expire: DateTime.now().add(Duration(minutes: expireMinutes)),
      serialized: serialized,
    );
    if (box.containsKey(key)) {
      box.delete(key);
    }
    box.put(key, model);
  }

  Future<void> storeMany(
      String boxName, int expireMinutes, Map<String, String> serializedKeyPairs) async {
    final box = await Hive.openBox<HiveModel>(boxName);
    final entries = serializedKeyPairs.map((key, value) => MapEntry(
          key,
          HiveModel(
            expire: DateTime.now().add(Duration(minutes: expireMinutes)),
            serialized: value,
          ),
        ));
    box.putAll(entries);
  }

  Future<String> get(String boxName, String key) async {
    final box = await Hive.openBox<HiveModel>(boxName);
    final stored = box.get(key);
    await box.close();
    return stored != null ? stored.serialized : '';
  }

  Future<List<String>> getMany(String boxName, List<String> keys) async {
    final box = await Hive.openBox<HiveModel>(boxName);
    final storedList = keys.map(box.get).toList();
    await box.close();
    return storedList.isNotEmpty ? storedList.map((stored) => stored!.serialized).toList() : [];
  }

  Future<List<String>> getAll(String boxName) async {
    final box = await Hive.openBox<HiveModel>(boxName);
    final stored = box.values;
    await box.close();
    return stored.isNotEmpty ? stored.map((stored) => stored.serialized).toList() : [];
  }

  Future<bool> containValidKey(String boxName, String key) async {
    final box = await Hive.openBox<HiveModel>(boxName);
    final stored = box.get(key);
    await box.close();
    if (stored != null) {
      return DateTime.now().isBefore(stored.expire);
    }
    return false;
  }
}
