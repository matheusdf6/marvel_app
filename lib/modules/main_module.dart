import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/core/connection/connection_service.dart';
import 'package:marvel_app/core/connection/connectivity_plus_service.dart';
import 'package:marvel_app/core/local_storage/hive/hive_storage.dart';
import 'package:marvel_app/modules/characters_module.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HiveStorage()),
        Bind.factory<ConnectionService>((i) => ConnectivityPlusService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: CharactersModule()),
      ];
}
