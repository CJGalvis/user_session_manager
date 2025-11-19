import 'package:flutter_test/flutter_test.dart';
import 'package:user_session_manager/src/session_manager.dart';

import '../mocks/face_storage_mock.dart';

void main() {
  group('SessionManager', () {
    late SessionManager manager;
    late FakeStorage fakeStorage;

    setUp(() {
      manager = SessionManager();
      fakeStorage = FakeStorage();
      manager.configure(storage: fakeStorage);
    });

    test('Guarda y obtiene token correctamente', () async {
      await manager.saveToken('abc123');
      final token = await manager.getToken();
      expect(token, 'abc123');
    });

    test('Limpia sesión correctamente', () async {
      await manager.saveToken('xyz999');
      await manager.clearSession();
      final token = await manager.getToken();
      expect(token, isNull);
    });

    test('Ejecuta callback al expirar sesión', () async {
      bool called = false;
      manager.configure(
        storage: fakeStorage,
        onSessionExpired: () async {
          called = true;
        },
      );

      await manager.handleUnauthorized();
      expect(called, isTrue);
    });
  });
}
