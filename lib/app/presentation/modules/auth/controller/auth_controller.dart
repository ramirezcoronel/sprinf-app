import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
import 'package:sprinf_app/app/data/services/local/encryption_service.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Map<String, String> data = {'correo': email, 'contrasena': password};
    String encrypted =
        await ref.read(encryptionServiceProvider).encrypt(jsonEncode(data));
    state = await AsyncValue.guard(
        () => ref.watch(authRepositoryProvider).login(encrypted));
  }
}
