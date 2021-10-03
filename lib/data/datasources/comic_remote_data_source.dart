import 'package:marvel_app/core/clients/marvel_api_client.dart';
import 'package:marvel_app/core/errors/exceptions.dart';
import 'package:marvel_app/data/models/comic_model.dart';

class ComicRemoteDataSource {
  final MarvelApiClient apiClient;

  ComicRemoteDataSource(this.apiClient);

  Future<List<ComicModel>> getByCharacter(int characterId) async {
    final response = await apiClient.get('/characters/$characterId/comics');

    if (response['code'] == 200) {
      return List.from(response['data']['results'])
            .map((data) => ComicModel.fromRemoteJson(data))
            .toList();
    } else {
      throw ServerException();
    }
  }
}
