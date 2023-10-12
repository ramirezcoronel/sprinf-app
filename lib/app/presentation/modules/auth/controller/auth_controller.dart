import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
import 'package:sprinf_app/app/data/services/local/encryption_service.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/domain/either.dart';
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

    state = await AsyncValue.guard(() async {
      Either<HttpFailure, String> result =
          await ref.read(authRepositoryProvider).login(encrypted);

      result.when((failure) => throw Exception(failure.toString()),
          (encryptedToken) async {
        String token =
            await ref.read(encryptionServiceProvider).decrypt(encryptedToken);
        // ref.read(sessionServiceProvider).saveToken(token);
      });
    });
  }
}
