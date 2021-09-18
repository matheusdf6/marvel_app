abstract class Failure {
  final List<dynamic>? properties;

  const Failure({this.properties});
}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}
