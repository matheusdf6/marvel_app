import 'package:marvel_app/core/connection/connection_service.dart';
import 'package:marvel_app/data/datasources/comic_local_data_source.dart';
import 'package:marvel_app/data/datasources/comic_remote_data_source.dart';
import 'package:marvel_app/domain/entities/comic.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_app/domain/repositories/comic_repository.dart';

class ComicRepositoryImpl extends ComicRepository {
  final ComicRemoteDataSource remoteDataSource;
  final ComicLocalDataSource localDataSource;
  final ConnectionService connection;

  ComicRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connection,
  });

  @override
  Future<Either<Failure, List<Comic>>> getByCharacter(int characterId) async {
    if (await localDataSource.containsValidCharacterComics(characterId)) {
      try {
        final result = await localDataSource.getStoredCharacterComics(characterId);
        return Right(result);
      } catch (e) {
        return Left(LocalStorageFailure());
      }
    }
    if (await connection.isConnected()) {
      try {
        final result = await remoteDataSource.getByCharacter(characterId);
        localDataSource.storeCharacterComics(characterId, result);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }
}
