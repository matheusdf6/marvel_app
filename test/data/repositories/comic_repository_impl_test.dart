import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/errors/exceptions.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/data/datasources/comic_remote_data_source.dart';
import 'package:marvel_app/data/models/character_model.dart';
import 'package:marvel_app/data/models/comic_model.dart';
import 'package:marvel_app/data/repositories/character_repository_impl.dart';
import 'package:marvel_app/data/repositories/comic_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comic_repository_impl_test.mocks.dart';

@GenerateMocks([ComicRemoteDataSource])
void main() {
  late MockComicRemoteDataSource mockedDatasource;
  late ComicRepositoryImpl repository;
  const testCharacterModel = ComicModel(
    id: 99460,
    title: 'Spider-Gwen Infinity Comic Primer (2021) #1',
    thumbnail: 'http://i.annihil.us/u/prod/marvel/i/mg/1/b0/613ac5ddabfe1.jpg',
  );

  final testListModel = [testCharacterModel];

  setUp(() {
    mockedDatasource = MockComicRemoteDataSource();
    repository = ComicRepositoryImpl(remoteDataSource: mockedDatasource);
  });

  group('getByCharacter', () {
    test('should return Comic when id is correct', () async {
      // Arrange
      when(mockedDatasource.getByCharacter(any)).thenAnswer((_) async => Future.value(testListModel));
      // Act
      final result = await repository.getByCharacter(1);
      // Assert
      verify(mockedDatasource.getByCharacter(1));
      expect(result, Right(testListModel));
    });

    test('should return ServerFailure when any other error occurs', () async {
      // Arrange
      when(mockedDatasource.getByCharacter(any)).thenThrow(ServerException());
      // Act
      final result = await repository.getByCharacter(1);
      // Assert
      verify(mockedDatasource.getByCharacter(1));
      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should not be here'),
      );
    });
  });
}
