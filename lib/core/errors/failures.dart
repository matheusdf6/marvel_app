abstract class Failure {
  final List<dynamic>? properties;

  Failure({this.properties});
}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class NotFoundFailure extends Failure {}

class NoMoreCharactersFailure extends Failure {}
