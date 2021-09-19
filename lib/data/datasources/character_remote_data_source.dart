import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:marvel_app/data/models/character_model.dart';

class CharacterRemoteDataSource {
  final MarvelApiClient apiClient;

  CharacterRemoteDataSource(this.apiClient);

  Future<List<CharacterModel>> index(int offset) async {
    final response = await apiClient.get('/characters?offset=$offset');
    return List.from(response['results']).map((data) => CharacterModel.fromJson(data)).toList();
  }

  Future<CharacterModel> show(int id) async {
    final response = await apiClient.get('/characters/$id');
    return CharacterModel.fromJson(response);
  }
}
