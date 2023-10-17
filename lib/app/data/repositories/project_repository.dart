import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/domain/model/project.dart';

import '../../domain/either.dart';

part 'project_repository.g.dart';

class ProjectRepository {
  ProjectRepository(this._http);
  final Http _http;

  Future<List<Project>?> listar() async {
    final result = await _http.request('api/proyectos',
        useToken: true, method: HttpMethod.post, onSucess: (responseBody) {
      if (responseBody is Iterable) {
        List<Project> resultado = responseBody
            .map((estudiante) => Project.fromJson(estudiante))
            .toList();
        return resultado;
      }
    });

    return result.when(
        (failure) => throw HttpFailure(
            exception: failure.exception.toString(),
            statusCode: failure.statusCode),
        (estudiantes) => estudiantes);
  }

  Future<Either<HttpFailure, Project>> obtener(String id) async {
    final result = await _http.request('api/proyecto/$id',
        useToken: true, method: HttpMethod.post, onSucess: (responseBody) {
      Project estudiante = Project.fromJson(responseBody);
      return estudiante;
    });

    return result.when((error) => Either.left(error),
        (estudiante) => Either.right(estudiante));
  }
}

@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  return ProjectRepository(
      ref.watch(HttpProvider(baseUrl: 'http://192.168.86.1:8080/')));
}

@riverpod
Future<List<Project>?> listarProyectos(ListarProyectosRef ref) async {
  return await ref.read(projectRepositoryProvider).listar();
}
