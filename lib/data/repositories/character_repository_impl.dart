import 'package:marvel_app/data/datasources/character_remote_data_source.dart';
import 'package:marvel_app/domain/entities/character.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_app/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Character>> getDetails(int id) async {
    try {
      final character = await remoteDataSource.show(id);
      storeInCache(character);
      return Right(character as Character);
    } on Exception {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getMany(int offset) async {
    try {
      final characterList = await remoteDataSource.index(offset);
      characterList.forEach(storeInCache);
      return Right(characterList as List<Character>);
    } on Exception {
      return Left(NetworkFailure());
    }
  }

  void storeInCache(character) {
    // TODO Implementar cache
  }
}
