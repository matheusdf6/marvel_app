import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/entities/character.dart';
import 'package:marvel_app/domain/repositories/character_repository.dart';
import 'package:marvel_app/domain/usecases/get_character_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_character_list_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  late MockCharacterRepository mockedRepository;
  late GetCharacterList getCharacterList;
  final testCharacterList = [
    Character(
      id: 1,
      name: 'Teste',
      description: 'Teste',
      thumbnail: 'Teste',
      comics: ['Teste'],
    ),
  ];

  setUp(() {
    mockedRepository = MockCharacterRepository();
    getCharacterList = GetCharacterList(mockedRepository);
  });

  test('should return the character list when there is not offset', () async {
    // Arrange
    when(mockedRepository.getMany(0)).thenAnswer((_) async => Right(testCharacterList));
    // Act
    final result = await getCharacterList(GetCharacterListParams());
    // Assert
    expect(result, Right(testCharacterList));
  });

  test('should return the character list when offset parameter is present', () async {
    // Arrange
    const testOffset = 10;
    when(mockedRepository.getMany(testOffset)).thenAnswer((_) async => Right(testCharacterList));

    // Act
    final result = await getCharacterList(GetCharacterListParams(offset: testOffset));

    // Assert
    expect(result, Right(testCharacterList));

    result.fold(
      (l) => fail('Should not be here'),
      (right) => expect(right, testCharacterList),
    );
  });

  test('should return a NoMoreCharactersFailure when offset is bigger than data source', () async {
    // Arrange
    const testOffset = 1600;
    when(mockedRepository.getMany(testOffset))
        .thenAnswer((_) async => Left(NoMoreCharactersFailure()));

    // Act
    final result = await getCharacterList(GetCharacterListParams(offset: testOffset));

    // Assert
    expect(result, isA<Left>());
    result.fold(
      (left) => expect(left, isA<NoMoreCharactersFailure>()),
      (r) => fail('Should not be here'),
    );
  });

  test('should return a failure when an error occur', () async {
    // Arrange
    when(mockedRepository.getMany(0)).thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await getCharacterList(GetCharacterListParams());

    // Assert
    expect(result, isA<Left>());
    result.fold(
      (left) => expect(left, isA<ServerFailure>()),
      (r) => fail('Should not be here'),
    );
  });
}
