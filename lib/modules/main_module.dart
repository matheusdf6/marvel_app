import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/modules/characters_module.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: CharactersModule()),
      ];
}
