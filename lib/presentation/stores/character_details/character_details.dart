import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/entities/comic.dart';
import 'package:marvel_app/domain/usecases/get_character_comics.dart';
import 'package:marvel_app/domain/usecases/get_character_details.dart';
import 'package:mobx/mobx.dart';

part 'character_details.g.dart';

class CharacterDetails = CharacterDetailsBase with _$CharacterDetails;

abstract class CharacterDetailsBase with Store {
  final GetCharacterComics getCharacterComics;

  CharacterDetailsBase({
    required this.getCharacterComics,
  });

  @observable
  List<Comic> comics = [];

  @observable
  bool loading = false;

  @observable
  String errorMessage = '';

  @action
  Future<void> loadCharacterDetails(int id) async {
    loading = true;
    final result = await getCharacterComics(GetCharacterComicsParams(characterId: id));
    result.fold(
      (failure) {
        errorMessage = 'Não foi possivel carregar os quadrinhos do personagem';
      }, 
      (comicResult) {
        comics = comicResult;
      }
    );
    loading = false;
  }
}
