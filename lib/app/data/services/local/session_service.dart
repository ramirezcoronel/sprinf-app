import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/domain/model/user.dart';

part 'session_service.g.dart';

const _userKey = 'usuario';
const _tokenKey = 'token';
const _publicKey = 'publickey';
const _privateKey = 'privatekey';

class SessionService {
  final FlutterSecureStorage _secureStorage;

  SessionService(this._secureStorage);

  Future<String?> get token async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<bool> isLoggedIn() async {
    String? token = await this.token;
    print('token, ${token}');
    if (token == null) return false;
    User? user = await getUser();
    if (user == null) return false;
    return true;
  }

  Future<void> saveToken(String token) {
    return _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> saveUser(User user) {
    // prefs.set
    String stringUser = jsonEncode(user.toJson());
    return _secureStorage.write(key: _userKey, value: stringUser);
  }

  Future<User> getUser() async {
    String? stringUser = await _secureStorage.read(key: _userKey);
    if (stringUser == null) throw Exception('Usuario no encontrado');

    return User.fromJson(jsonDecode(stringUser));
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
  return SessionService(
    const FlutterSecureStorage(),
  );
}

@riverpod
Future<bool> loadBundle(LoadBundleRef ref) async {
  return await ref.read(sessionServiceProvider).loadBundleIntoStorage();
}

@riverpod
Future<bool> isLoggedIn(IsLoggedInRef ref) async {
  return await ref.read(sessionServiceProvider).isLoggedIn();
}

@riverpod
Future<User> getUser(GetUserRef ref) async {
  return await ref.read(sessionServiceProvider).getUser();
}
