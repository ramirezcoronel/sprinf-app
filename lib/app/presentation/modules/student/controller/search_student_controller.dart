import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/domain/model/student.dart';

part 'search_student_controller.g.dart';

@riverpod
class SearchStudentController extends _$SearchStudentController {
  @override
  FutureOr<List<Student>?> build(List<Student> initial) async {
    state = const AsyncValue.loading();

    state = AsyncValue.data(initial);
    return initial;
  }

  Future<List<Student>?> filter(List<Student> total, String busqueda) async {
    state = const AsyncValue.loading();

    List<Student>? searchResult = [];
    if (busqueda.isEmpty) {
      state = AsyncValue.data(total);
      return total;
    } else {
      for (var userDetail in total) {
        if (userDetail.nombre.toLowerCase().contains(busqueda.toLowerCase()) ||
            userDetail.apellido
                .toLowerCase()
                .contains(busqueda.toLowerCase()) ||
            userDetail.cedula.contains(busqueda.toLowerCase())) {
          searchResult.add(userDetail);
        }
      }

      state = AsyncValue.data(searchResult);
      return searchResult;
    }
  }
}
