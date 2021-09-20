// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_details.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharacterDetails on CharacterDetailsBase, Store {
  final _$nameAtom = Atom(name: 'CharacterDetailsBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$descriptionAtom = Atom(name: 'CharacterDetailsBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$thumbnailAtom = Atom(name: 'CharacterDetailsBase.thumbnail');

  @override
  String get thumbnail {
    _$thumbnailAtom.reportRead();
    return super.thumbnail;
  }

  @override
  set thumbnail(String value) {
    _$thumbnailAtom.reportWrite(value, super.thumbnail, () {
      super.thumbnail = value;
    });
  }

  final _$comicsAtom = Atom(name: 'CharacterDetailsBase.comics');

  @override
  List<String> get comics {
    _$comicsAtom.reportRead();
    return super.comics;
  }

  @override
  set comics(List<String> value) {
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
name: ${name},
description: ${description},
thumbnail: ${thumbnail},
comics: ${comics},
loading: ${loading},
errorMessage: ${errorMessage}
    ''';
  }
}
