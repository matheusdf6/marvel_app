import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/entities/comic.dart';

abstract class ComicsRepository {
  
  Future<Either<Failure, List<Comic>>> getByCharacter(int characterId);
}