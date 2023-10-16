import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/domain/model/project.dart';

import '../../domain/either.dart';

part 'project_repository.g.dart';

class ProjectRepository {
  ProjectRepository(this._http);
  final Http _http;

  Future<Either<HttpFailure, Project>> obtener(String id) async {
    return Future.value(Either.right(const Project(
        id: 1,
        nombre: "Sistema de Gestión de Proyectos Sociotecnologicos",
        comunidad: "UPTAEB",
        direccion: "Av. La Salle",
        tutorEx: "Jose Sequera",
        tutorInNombre: "Sonia",
        tutorInCedula: "235465",
        nombreTrayecto: "Trayecto III",
        nombreFase: "Fase I",
        fechaInicio: "2023-02-01",
        fechaCierre: "2024-03-01")));
  }
}

@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref, String token) {
  return ProjectRepository(ref.watch(
      HttpProvider(baseUrl: 'http://192.168.0.105:8080/', token: token)));
}
