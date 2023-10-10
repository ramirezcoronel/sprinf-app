import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_service.g.dart';

const _tokenKey = 'token';

class SessionService {
  final FlutterSecureStorage _secureStorage;

  SessionService(this._secureStorage);

  Future<String?> get token async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> saveToken(String token) {
    return _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteAll() async {
    return await _secureStorage.deleteAll();
  }
}

@riverpod
SessionService sessionService(SessionServiceRef ref) {
  return SessionService(const FlutterSecureStorage());
}
