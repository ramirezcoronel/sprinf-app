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
        final data = jsonDecode(response);
        String token = data['request_token'];

        Map<String, dynamic> userData = data['userData'];

        User user = User.fromJson(userData);
        appUser = user;
        ref.read(sessionServiceProvider).saveToken(token);
        ref.read(sessionServiceProvider).saveUser(user);
      });
    });
  }
}
