import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/domain/model/project.dart';

part 'search_project_controller.g.dart';

@riverpod
class SearchProjectController extends _$SearchProjectController {
  @override
  FutureOr<List<Project>?> build(List<Project> initial) async {
    state = const AsyncValue.loading();

    state = AsyncValue.data(initial);
    return initial;
  }

  Future<List<Project>?> filter(List<Project> total, String busqueda) async {
    state = const AsyncValue.loading();

    List<Project>? searchResult = [];
    if (busqueda.isEmpty) {
      state = AsyncValue.data(total);
      return total;
    } else {
      for (var userDetail in total) {
        if (userDetail.nombre.toLowerCase().contains(busqueda.toLowerCase()) ||
            userDetail.nombreTrayecto
                .toLowerCase()
                .contains(busqueda.toLowerCase()) ||
            userDetail.tutorInNombre.contains(busqueda.toLowerCase())) {
          searchResult.add(userDetail);
        }
      }

      state = AsyncValue.data(searchResult);
      return searchResult;
    }
  }
}
