import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';

import '../../domain/either.dart';

// part 'project_repository.g.dart';

class ProjectRepository {
  ProjectRepository(this._http);
  final Http _http;

  Future<Either<HttpFailure, String>> obtener(String id) async {
    throw UnimplementedError();
  }
}
