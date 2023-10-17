import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/repositories/baremos_repository.dart';
import 'package:sprinf_app/app/data/repositories/student_repository.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/domain/model/student.dart';

import '../../../../domain/model/fase.dart';

part 'baremos_details_controller.g.dart';

@riverpod
class BaremosDetailsController extends _$BaremosDetailsController {
  @override
  FutureOr<List<Fase>?> build(String id) async {
    // no-op
    state = const AsyncValue.loading();

    String? token = await ref.read(sessionServiceProvider).token;
    if (token == null) throw Exception('Token no definido');
    final resultado = await ref.read(baremosRepositoryProvider).obtener(id);
    return resultado.when((p0) => throw Exception('Error al obtener Baremos'),
        (estudiante) => estudiante);
  }
}
