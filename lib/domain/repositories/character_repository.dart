import 'package:dartz/dartz.dart';
import 'package:marvel_app/core/errors/failures.dart';
import 'package:marvel_app/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getMany(int offset);
  Future<Either<Failure, List<Character>>> getDetails(int id);
}
