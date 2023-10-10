import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'encryption_service.g.dart';

class EncryptionService {
  final String _publicKey;
  final String _privateKey;

  EncryptionService(this._publicKey, this._privateKey);

  Future<String> encrypt(message) async {
    return await RSA.encryptPKCS1v15(message, _publicKey);
  }

  Future<String> decrypt(message) async {
    return await RSA.decryptPKCS1v15(message, _privateKey);
  }
}

@riverpod
Future<EncryptionService> encryptionService(EncryptionServiceRef ref) async {
  String privateKey =
      await rootBundle.loadString('assets/keys/private_key.pem');
  String publicKey = await rootBundle.loadString('assets/keys/public_key.pem');

  return EncryptionService(publicKey, privateKey);
}
