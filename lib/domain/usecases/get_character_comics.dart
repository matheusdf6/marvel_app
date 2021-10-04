import 'package:marvel_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/usecase/usecase.dart';
import 'package:marvel_app/domain/entities/comic.dart';
import 'package:marvel_app/domain/repositories/comic_repository.dart';

class GetCharacterComics extends UseCase<List<Comic>, GetCharacterComicsParams> {
  final ComicRepository repository;

  GetCharacterComics(this.repository);

  @override
  Future<Either<Failure, List<Comic>>> call(GetCharacterComicsParams params) async {
    return await repository.getByCharacter(params.characterId);
  }
}

class GetCharacterComicsParams {
  final int characterId;

  GetCharacterComicsParams({
    required this.characterId
  });
}
