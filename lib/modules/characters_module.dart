import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_app/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/data/datasources/comic_local_data_source.dart';
import 'package:marvel_app/data/datasources/comic_remote_data_source.dart';
import 'package:marvel_app/data/repositories/character_repository_impl.dart';
import 'package:marvel_app/data/repositories/comic_repository_impl.dart';
import 'package:marvel_app/domain/repositories/character_repository.dart';
import 'package:marvel_app/domain/repositories/comic_repository.dart';
import 'package:marvel_app/domain/usecases/get_character_comics.dart';
import 'package:marvel_app/domain/usecases/get_character_details.dart';
import 'package:marvel_app/domain/usecases/get_character_list.dart';
import 'package:marvel_app/presentation/screens/character_screen.dart';
import 'package:marvel_app/presentation/screens/home_screen.dart';
import 'package:marvel_app/presentation/stores/character_details/character_details.dart';
import 'package:marvel_app/presentation/stores/character_list/character_list.dart';

class CharactersModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((_i) => MarvelApiClient(
              baseurl: dotenv.get('MARVEL_API_BASE', fallback: ''),
              public: dotenv.get('MARVEL_API_PUBLIC', fallback: ''),
              private: dotenv.get('MARVEL_API_PRIVATE', fallback: ''),
              client: http.Client(),
            )),
        Bind.factory((i) => CharacterRemoteDataSource(i())),
        Bind.factory((i) => ComicRemoteDataSource(i())),
        Bind.factory((i) => ComicLocalDataSource(storage: i())),
        Bind.factory<CharacterRepository>((i) => CharacterRepositoryImpl(remoteDataSource: i())),
        Bind.factory<ComicRepository>((i) =>
            ComicRepositoryImpl(remoteDataSource: i(), connection: i(), localDataSource: i())),
        Bind.factory((i) => GetCharacterDetails(i())),
        Bind.factory((i) => GetCharacterList(i())),
        Bind.factory((i) => GetCharacterComics(i())),
        Bind.factory((i) => CharacterDetails(getCharacterComics: i())),
        Bind.factory((i) => CharacterList(getCharacterList: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomeScreen()),
        ChildRoute(
          '/character',
          child: (context, args) => CharacterScreen(
            params: CharacterScreenParams(
              character: args.data,
            ),
          ),
          transition: TransitionType.rightToLeftWithFade,
        ),
      ];
}
