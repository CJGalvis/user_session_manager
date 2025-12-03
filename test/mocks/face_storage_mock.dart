import 'package:user_session_manager/user_session_manager.dart';

class FakeStorage extends SessionStorage {
  final Map<String, String?> memory = {};

  @override
  Future<void> saveToken(String token) async =>
      memory['auth_token'] = token;

  @override
  Future<String> getToken() async => memory['auth_token'] ?? '';

  @override
  Future<void> clear() async => memory.clear();
}
