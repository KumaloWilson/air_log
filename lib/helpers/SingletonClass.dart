class TokenManager {
  static TokenManager? _instance;
  String? accessToken;
  String? refreshToken;

  factory TokenManager() {
    return _instance ??= TokenManager._();
  }

  TokenManager._();
}