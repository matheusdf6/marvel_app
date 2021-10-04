// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_details.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharacterDetails on CharacterDetailsBase, Store {
  final _$comicsAtom = Atom(name: 'CharacterDetailsBase.comics');

  @override
  List<Comic> get comics {
    _$comicsAtom.reportRead();
    return super.comics;
  }

  @override
  set comics(List<Comic> value) {
    _$comicsAtom.reportWrite(value, super.comics, () {
      super.comics = value;
    });
  }

  final _$loadingAtom = Atom(name: 'CharacterDetailsBase.loading');

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

  final _$errorMessageAtom = Atom(name: 'CharacterDetailsBase.errorMessage');

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

  final _$loadCharacterDetailsAsyncAction =
      AsyncAction('CharacterDetailsBase.loadCharacterDetails');

  @override
  Future<void> loadCharacterDetails(int id) {
    return _$loadCharacterDetailsAsyncAction
        .run(() => super.loadCharacterDetails(id));
  }

  @override
  String toString() {
    return '''
comics: ${comics},
loading: ${loading},
errorMessage: ${errorMessage}
    ''';
  }
}
