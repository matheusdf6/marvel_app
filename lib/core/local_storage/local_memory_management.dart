abstract class LocalMemoryManagement<T> {
  int get minutesForExpiring;
  Future<bool> containsValid(String key);
  Future<void> store(String key, T object);
  Future<T> getStored(String key);
}
