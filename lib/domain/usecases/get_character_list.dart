import 'package:marvel_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/usecase/usecase.dart';
import 'package:marvel_app/domain/entities/character.dart';
import 'package:marvel_app/domain/repositories/character_repository.dart';

class GetCharacterList extends UseCase<List<Character>, GetCharacterListParams> {
  final CharacterRepository repository;

  GetCharacterList(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(GetCharacterListParams params) async {
    return await repository.getMany(params.offset);
  }
}

class GetCharacterListParams {
  final int offset;

  GetCharacterListParams({this.offset = 0});
}
