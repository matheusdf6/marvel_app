import 'package:marvel_app/data/datasources/comic_remote_data_source.dart';
import 'package:marvel_app/domain/entities/comic.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_app/domain/repositories/comic_repository.dart';

class ComicRepositoryImpl extends ComicsRepository {
  final ComicRemoteDataSource remoteDataSource;

  ComicRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Comic>>> getByCharacter(int characterId) async {
    try {
      final result = await remoteDataSource.getByCharacter(characterId);
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

}