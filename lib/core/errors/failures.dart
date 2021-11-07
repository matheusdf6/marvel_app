abstract class Failure {
  final List<dynamic>? properties;

  Failure({this.properties});
}

class LocalStorageFailure extends Failure {}

class ServerFailure extends Failure {}

class NotFoundFailure extends Failure {}

class NoMoreCharactersFailure extends Failure {}
