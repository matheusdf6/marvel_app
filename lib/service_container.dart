import 'package:flutter/material.dart';
import 'package:marvel_app/data/datasources/comic_remote_data_source.dart';
import 'package:marvel_app/data/repositories/comic_repository_impl.dart';
import 'package:marvel_app/domain/repositories/comic_repository.dart';
import 'package:marvel_app/domain/usecases/get_character_comics.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:marvel_app/data/repositories/character_repository_impl.dart';
import 'package:marvel_app/domain/usecases/get_character_details.dart';
import 'package:marvel_app/domain/usecases/get_character_list.dart';
import 'package:marvel_app/presentation/stores/character_details/character_details.dart';
import 'package:marvel_app/presentation/stores/character_list/character_list.dart';
import 'package:marvel_app/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/domain/repositories/character_repository.dart';

class ServiceContainer extends StatelessWidget {
  final Widget child;

  const ServiceContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MarvelApiClient>(
          create: (_) => MarvelApiClient(
            baseurl: dotenv.get('MARVEL_API_BASE', fallback: ''),
            public: dotenv.get('MARVEL_API_PUBLIC', fallback: ''),
            private: dotenv.get('MARVEL_API_PRIVATE', fallback: ''),
            client: http.Client(),
          ),
        ),
        ProxyProvider<MarvelApiClient, CharacterRemoteDataSource>(
          update: (_, apiClient, __) => CharacterRemoteDataSource(apiClient),
        ),
        ProxyProvider<MarvelApiClient, ComicRemoteDataSource>(
          update: (_, apiClient, __) => ComicRemoteDataSource(apiClient),
        ),
        ProxyProvider<CharacterRemoteDataSource, CharacterRepository>(
          update: (_, remote, __) => CharacterRepositoryImpl(remoteDataSource: remote),
        ),
        ProxyProvider<ComicRemoteDataSource, ComicRepository>(
          update: (_, remote, __) => ComicRepositoryImpl(remoteDataSource: remote),
        ),
        ProxyProvider<CharacterRepository, GetCharacterDetails>(
          update: (_, repository, __) => GetCharacterDetails(repository),
        ),
        ProxyProvider<CharacterRepository, GetCharacterList>(
          update: (_, repository, __) => GetCharacterList(repository),
        ),
        ProxyProvider<ComicRepository, GetCharacterComics>(
          update: (_, repository, __) => GetCharacterComics(repository),
        ),
        ProxyProvider<GetCharacterComics, CharacterDetails>(
          update: (_, usecase, __) => CharacterDetails(getCharacterComics: usecase),
        ),
        ProxyProvider<GetCharacterList, CharacterList>(
          update: (_, usecase, __) => CharacterList(getCharacterList: usecase),
        ),
      ],
      child: child,
    );
  }
}
