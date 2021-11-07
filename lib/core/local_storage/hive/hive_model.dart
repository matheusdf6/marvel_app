import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 1)
class HiveModel extends HiveObject {
  @HiveField(0)
  final DateTime expire;

  @HiveField(1)
  final String serialized;

  HiveModel({
    required this.expire,
    required this.serialized,
  });
}
