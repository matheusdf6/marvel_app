import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/errors/exceptions.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/data/models/character_model.dart';
import 'package:marvel_app/data/repositories/character_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'character_repository_impl_test.mocks.dart';

@GenerateMocks([CharacterRemoteDataSource])
void main() {
  late MockCharacterRemoteDataSource mockedDatasource;
  late CharacterRepositoryImpl repository;
  final testCharacterModel = CharacterModel(
    id: 1,
    name: 'Teste',
    description: 'Descrição teste',
    thumbnail: 'http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg',
  );
  final testListModel = [testCharacterModel];

  setUp(() {
    mockedDatasource = MockCharacterRemoteDataSource();
    repository = CharacterRepositoryImpl(remoteDataSource: mockedDatasource);
  });

  group('getDetails', () {
    test('should return Character when id is correct', () async {
      // Arrange
      when(mockedDatasource.show(any)).thenAnswer((_) async => Future.value(testCharacterModel));
      // Act
      final result = await repository.getDetails(1);
      // Assert
      verify(mockedDatasource.show(1));
      expect(result, Right(testCharacterModel));
    });

    test('should return NotFoundFailure when character is not found', () async {
      // Arrange
      when(mockedDatasource.show(any)).thenThrow(NotFoundException());
      // Act
      final result = await repository.getDetails(1);
      // Assert
      verify(mockedDatasource.show(1));
      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<NotFoundFailure>()),
        (r) => fail('Should not be here'),
      );
    });

    test('should return ServerFailure when any other error occurs', () async {
      // Arrange
      when(mockedDatasource.show(any)).thenThrow(ServerException());
      // Act
      final result = await repository.getDetails(1);
      // Assert
      verify(mockedDatasource.show(1));
      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should not be here'),
      );
    });
  });

  group('getMany', () {
    test('should return Character List', () async {
      // Arrange
      when(mockedDatasource.index(any)).thenAnswer((_) async => testListModel);
      // Act
      final result = await repository.getMany(0);
      // Assert
      verify(mockedDatasource.index(0));
      expect(result, equals(Right(testListModel)));
    });

    test('should return ServerFailure when any error occurs', () async {
      // Arrange
      when(mockedDatasource.index(any)).thenThrow(ServerException());
      // Act
      final result = await repository.getMany(0);
      // Assert
      verify(mockedDatasource.index(0));
      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should not be here'),
      );
    });
  });
}
