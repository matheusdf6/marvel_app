import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/usecases/get_character_details.dart';
import 'package:mobx/mobx.dart';

part 'character_details.g.dart';

class CharacterDetails = CharacterDetailsBase with _$CharacterDetails;

abstract class CharacterDetailsBase with Store {
  final GetCharacterDetails getCharacterDetails;

  CharacterDetailsBase({required this.getCharacterDetails});

  @observable
  String name = '';

  @observable
  String description = '';

  @observable
  String thumbnail = '';

  @observable
  List<String> comics = [];

  @observable
  bool loading = false;

  @observable
  String errorMessage = '';

  @action
  Future<void> loadCharacterDetails(int id) async {
    loading = true;
    final result = await getCharacterDetails(GetCharacterDetailsParams(id: id));
    loading = false;
    result.fold(
      (failure) {
        if (failure is NotFoundFailure) {
          errorMessage = 'O personagem não foi encontrado';
        } else if (failure is ServerFailure) {
          errorMessage =
              'Ops! Não foi possível carregar os personagens, confira sua conexão com a rede.';
        } else {
          errorMessage = 'Aconteceu um erro inesperado, tente novamente mais tarde.';
        }
      },
      (character) {
        name = character.name;
        description = character.description;
        thumbnail = character.thumbnail;
        comics = character.comics;
      },
    );
  }
}
