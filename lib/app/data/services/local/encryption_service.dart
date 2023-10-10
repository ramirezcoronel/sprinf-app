import 'package:fast_rsa/fast_rsa.dart';
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
EncryptionService encryptionService(EncryptionServiceRef ref) {
  return EncryptionService('public', 'private');
}

@riverpod
Future<String> encrypt(EncryptRef ref, String message) async {
  return await ref.read(encryptionServiceProvider).encrypt(message);
}
