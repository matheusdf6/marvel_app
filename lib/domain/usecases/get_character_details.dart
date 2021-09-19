import 'package:marvel_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/usecase/usecase.dart';
import 'package:marvel_app/domain/entities/character.dart';
import 'package:marvel_app/domain/repositories/character_repository.dart';

class GetCharacterDetails extends UseCase<Character, GetCharacterDetailsParams> {
  final CharacterRepository repository;

  GetCharacterDetails(this.repository);

  @override
  Future<Either<Failure, Character>> call(GetCharacterDetailsParams params) async {
    return await repository.getDetails(params.id);
  }
}

class GetCharacterDetailsParams {
  final int id;

  GetCharacterDetailsParams({required this.id});
}
