import 'package:flutter_test/flutter_test.dart';

import '../mocks/face_storage_mock.dart';

void main() {
  group('SessionStorage', () {
    late FakeStorage storage;

    setUp(() {
      storage = FakeStorage();
    });

    test('Guarda y obtiene el token correctamente', () async {
      await storage.saveToken('abc123');
      final token = await storage.getToken();
      expect(token, 'abc123');
    });

    test('Limpia el token', () async {
      await storage.saveToken('token_test');
      await storage.clear();
      final token = await storage.getToken();
      expect(token, isNull);
    });
  });
}
