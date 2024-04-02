abstract class LocalDataSource {
  void logout();

  String? get authToken;
  set authToken(String? value);
}
