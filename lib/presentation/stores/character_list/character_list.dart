import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/entities/character.dart';
import 'package:marvel_app/domain/usecases/get_character_list.dart';
import 'package:mobx/mobx.dart';

part "character_list.g.dart";

class CharacterList = CharacterListBase with _$CharacterList;

abstract class CharacterListBase with Store {
  final GetCharacterList getCharacterList;

  CharacterListBase({required this.getCharacterList});

  @observable
  List<Character> characters = [];

  @observable
  bool loading = false;

  @observable
  String errorMessage = '';

  @action
  void loadCharacters() async {
    loading = true;
    final result = await getCharacterList(GetCharacterListParams(offset: characters.length));
    loading = false;
    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          errorMessage =
              'Ops! Não foi possível carregar os personagens, confira sua conexão com a rede.';
        } else {
          errorMessage = 'Aconteceu um erro inesperado, tente novamente mais tarde.';
        }
      },
      (success) {
        characters = success;
      },
    );
  }
}
