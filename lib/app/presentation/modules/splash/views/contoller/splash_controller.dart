import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
import 'package:sprinf_app/app/data/services/local/encryption_service.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/domain/either.dart';
import 'package:sprinf_app/app/domain/model/user.dart';
part 'splash_controller.g.dart';

@riverpod
class SplashController extends _$SplashController {
  @override
  FutureOr<User?> build() async {
    state = const AsyncValue.loading();

    return ref.read(sessionServiceProvider).getUser();
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(sessionServiceProvider).deleteAll();
      return null;
    });
  }

  User login(User user) {
    state = AsyncData(user);
    return user;
  }
}
