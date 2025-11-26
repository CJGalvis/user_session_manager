import 'session_storage.dart';

typedef OnSessionExpired = Future<void> Function();

class SessionManager {
  SessionManager._internal();
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;

  SessionStorage _storage = SessionStorage();
  OnSessionExpired? _onSessionExpired;

  void configure({
    OnSessionExpired? onSessionExpired,
    SessionStorage? storage,
  }) {
    _onSessionExpired = onSessionExpired;
    if (storage != null) _storage = storage;
  }

  Future<void> saveToken(String token) => _storage.saveToken(token);

  Future<String?> getToken() => _storage.getToken();

  Future<void> clearSession() => _storage.clear();

  Future<void> handleUnauthorized() async {
    await clearSession();
    if (_onSessionExpired != null) {
      await _onSessionExpired?.call();
    }
  }

  Future<String?> getUserSession() => _storage.getUser();

  Future<void> setUserSession(String data) => _storage.setUser(data);
}
