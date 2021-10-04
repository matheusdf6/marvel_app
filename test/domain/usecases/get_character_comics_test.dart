import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/entities/comic.dart';
import 'package:marvel_app/domain/repositories/comic_repository.dart';
import 'package:marvel_app/domain/usecases/get_character_comics.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_character_comics_test.mocks.dart';

@GenerateMocks([ComicRepository])
void main() {
  late MockComicRepository mockedRepository;
  late GetCharacterComics getCharacterDetails;
  const testId = 1;
  const testComics = [
    Comic(
      id: 1,
      title: 'Teste',
      thumbnail: 'Teste',
    ),
  ];

  setUp(() {
    mockedRepository = MockComicRepository();
    getCharacterDetails = GetCharacterComics(mockedRepository);
  });

  test('should return the character when id is correct', () async {
    // Arrange
    when(mockedRepository.getByCharacter(testId)).thenAnswer((_) async => const Right(testComics));
    // Act
    final result = await getCharacterDetails(GetCharacterComicsParams(
      characterId: testId,
    ));
    // Assert
    expect(result, const Right(testComics));

    result.fold(
      (l) => fail('Should not be here'),
      (right) => expect(right, testComics),
    );
  });

  test('should return a not found error when the character id does not exists', () async {
    // Arrange
    when(mockedRepository.getByCharacter(testId)).thenAnswer((_) async => Left(NotFoundFailure()));

    // Act
    final result = await getCharacterDetails(GetCharacterComicsParams(
      characterId: testId,
    ));

    // Assert
    expect(result, isA<Left>());

    result.fold(
      (left) => expect(left, isA<NotFoundFailure>()),
      (r) => fail('Should not be here'),
    );
  });

  test('should return a failure when occur error', () async {
    // Arrange
    when(mockedRepository.getByCharacter(testId)).thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await getCharacterDetails(GetCharacterComicsParams(
      characterId: testId,
    ));

    // Assert
    expect(result, isA<Left>());

    result.fold(
      (left) => expect(left, isA<ServerFailure>()),
      (r) => fail('Should not be here'),
    );
  });
}
