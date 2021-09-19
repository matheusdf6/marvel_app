import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:marvel_app/core/errors/exceptions.dart';
import 'package:marvel_app/data/models/character_model.dart';

class CharacterRemoteDataSource {
  final MarvelApiClient apiClient;

  CharacterRemoteDataSource(this.apiClient);

  Future<List<CharacterModel>> index(int offset) async {
    final response = await apiClient.get('/characters?offset=$offset');

    if (response['code'] == 200) {
      return List.from(response['data']['results'])
          .map((data) => CharacterModel.fromRemoteJson(data))
          .toList();
    } else {
      throw ServerException();
    }
  }

  Future<CharacterModel> show(int id) async {
    final response = await apiClient.get('/characters/$id');

    if (response['code'] == 200) {
      return CharacterModel.fromRemoteJson(response['data']['results'][0]);
    } else if (response['code'] == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
