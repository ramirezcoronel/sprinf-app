import 'package:fast_rsa/fast_rsa.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';

part 'encryption_service.g.dart';

class EncryptionService {
  final SessionService _sessionService;
  EncryptionService(this._sessionService);

  Future<String> encrypt(message) async {
    String publicKey = await _sessionService.getPublicKey() ?? '';
    return await RSA.encryptPKCS1v15(message, publicKey);
  }

  Future<String> decrypt(message) async {
    String privateKey = await _sessionService.getPrivateKey() ?? '';
    return await RSA.decryptPKCS1v15(message, privateKey);
  }
}

@riverpod
EncryptionService encryptionService(EncryptionServiceRef ref) {
  return EncryptionService(ref.watch(sessionServiceProvider));
}

@riverpod
Future<String> encrypt(EncryptRef ref, String message) async {
  return await ref.read(encryptionServiceProvider).encrypt(message);
}

@riverpod
Future<String> decrypt(DecryptRef ref, String message) async {
  return await ref.read(encryptionServiceProvider).decrypt(message);
}
