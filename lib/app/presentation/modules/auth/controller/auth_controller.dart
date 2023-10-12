import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
import 'package:sprinf_app/app/data/services/local/encryption_service.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/domain/either.dart';
import 'package:sprinf_app/app/domain/model/user.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  User? appUser;

  User? get getUser => appUser;

  Future<bool> get isLoggedIn async {
    String? token = await ref.watch(sessionServiceProvider).token;
    if (token == null) return false;
    User? user = await ref.read(sessionServiceProvider).getUser();
    if (token == null) return false;
    appUser = user;
    return true;
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
        String response =
            await ref.read(encryptionServiceProvider).decrypt(encryptedToken);
        print(response);
        // ref.read(sessionServiceProvider).saveToken(token);
      });
    });
  }
}
