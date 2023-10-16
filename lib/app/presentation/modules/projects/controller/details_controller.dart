import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
import 'package:sprinf_app/app/data/repositories/project_repository.dart';
import 'package:sprinf_app/app/data/services/local/encryption_service.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/domain/either.dart';
import 'package:sprinf_app/app/domain/model/project.dart';
import 'package:sprinf_app/app/domain/model/user.dart';
import 'package:sprinf_app/app/presentation/modules/splash/views/contoller/splash_controller.dart';

part 'details_controller.g.dart';

@riverpod
class DetailsController extends _$DetailsController {
  @override
  FutureOr<Project?> build(int id) async {
    // no-op
    state = const AsyncValue.loading();

    String? token = await ref.read(sessionServiceProvider).token;
    if (token == null) throw Exception('Token no definido');
    final resultado =
        await ref.read(projectRepositoryProvider(token)).obtener("1");
    return resultado.when((p0) => throw Exception('Error al obtener proyecto'),
        (proyecto) => proyecto);
  }
}
