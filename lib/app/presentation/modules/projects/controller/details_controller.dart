import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
import 'package:sprinf_app/app/data/services/local/encryption_service.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/domain/either.dart';
import 'package:sprinf_app/app/domain/model/user.dart';
import 'package:sprinf_app/app/presentation/modules/splash/views/contoller/splash_controller.dart';

part 'details_controller.g.dart';

@riverpod
class DetailsController extends _$DetailsController {
  @override
  FutureOr<void> build() {
    // no-op
    state = const AsyncValue.loading();

    return ref.read(sessionServiceProvider).getUser();
  }
}
