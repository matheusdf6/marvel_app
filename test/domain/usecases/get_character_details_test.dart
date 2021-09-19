import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/entities/character.dart';
import 'package:marvel_app/domain/repositories/character_repository.dart';
import 'package:marvel_app/domain/usecases/get_character_details.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_character_list_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  late MockCharacterRepository mockedRepository;
  late GetCharacterDetails getCharacterDetails;
  const testId = 1;
  final testCharacter = Character(
    id: 1,
    name: 'Teste',
    description: 'Teste',
    thumbnail: 'Teste',
    comics: ['Teste'],
  );

  setUp(() {
    mockedRepository = MockCharacterRepository();
    getCharacterDetails = GetCharacterDetails(mockedRepository);
  });

  test('should return the character when id is correct', () async {
    // Arrange
    when(mockedRepository.getDetails(testId)).thenAnswer((_) async => Right(testCharacter));
    // Act
    final result = await getCharacterDetails(GetCharacterDetailsParams(
      id: testId,
    ));
    // Assert
    expect(result, Right(testCharacter));

    result.fold(
      (l) => fail('Should not be here'),
      (right) => expect(right, testCharacter),
    );
  });

  test('should return a not found error when the character id does not exists', () async {
    // Arrange
    when(mockedRepository.getDetails(testId)).thenAnswer((_) async => Left(NotFoundFailure()));

    // Act
    final result = await getCharacterDetails(GetCharacterDetailsParams(
      id: testId,
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
    when(mockedRepository.getDetails(testId)).thenAnswer((_) async => Left(NetworkFailure()));

    // Act
    final result = await getCharacterDetails(GetCharacterDetailsParams(
      id: testId,
    ));

    // Assert
    expect(result, isA<Left>());

    result.fold(
      (left) => expect(left, isA<NetworkFailure>()),
      (r) => fail('Should not be here'),
    );
  });
}
