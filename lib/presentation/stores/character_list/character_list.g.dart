// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharacterList on CharacterListBase, Store {
  final _$charactersAtom = Atom(name: 'CharacterListBase.characters');

  @override
  List<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(List<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  final _$loadingAtom = Atom(name: 'CharacterListBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'CharacterListBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$loadCharactersAsyncAction =
      AsyncAction('CharacterListBase.loadCharacters');

  @override
  Future<void> loadCharacters() {
    return _$loadCharactersAsyncAction.run(() => super.loadCharacters());
  }

  @override
  String toString() {
    return '''
characters: ${characters},
loading: ${loading},
errorMessage: ${errorMessage}
    ''';
  }
}
