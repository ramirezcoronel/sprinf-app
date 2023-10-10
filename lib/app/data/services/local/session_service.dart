import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_service.g.dart';

const _tokenKey = 'token';
const _publicKey = 'publickey';
const _privateKey = 'privatekey';

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

  Future<String?> getPrivateKey() async {
    return await _secureStorage.read(key: _privateKey);
  }

  Future<String?> getPublicKey() async {
    return await _secureStorage.read(key: _publicKey);
  }

  Future<bool> loadBundleIntoStorage() async {
    try {
      String privateKey =
          await rootBundle.loadString('assets/keys/private_key.pem');
      String publicKey =
          await rootBundle.loadString('assets/keys/public_key.pem');

      _secureStorage.write(key: _publicKey, value: publicKey);
      _secureStorage.write(key: _privateKey, value: privateKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}

@riverpod
SessionService sessionService(SessionServiceRef ref) {
  return SessionService(const FlutterSecureStorage());
}

@riverpod
Future<bool> loadBundle(LoadBundleRef ref) async {
  return await ref.read(sessionServiceProvider).loadBundleIntoStorage();
}
