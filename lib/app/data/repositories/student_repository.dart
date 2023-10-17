import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/domain/model/student.dart';
import 'package:sprinf_app/app/domain/model/user.dart';

import '../../domain/either.dart';

part 'student_repository.g.dart';

class StudentRepository {
  StudentRepository(this._http);
  final Http _http;

  Future<Either<HttpFailure, List<Student>?>> listar() async {
    final result = await _http.request('api/estudiantes/listar',
        useToken: true, method: HttpMethod.post, onSucess: (responseBody) {
      if (responseBody is Iterable) {
        List<Student> resultado = responseBody
            .map((estudiante) => Student.fromJson(estudiante))
            .toList();
        return resultado;
      }
    });

    return result.when((failure) => Either.left(failure),
        (estudiantes) => Either.right(estudiantes));
  }

  Future<Either<HttpFailure, Student>> obtener(String id) async {
    final result = await _http.request('api/estudiantes',
        useToken: true,
        method: HttpMethod.post,
        body: {
          "data": {"codigo": id}
        }, onSucess: (responseBody) {
      Student estudiante = Student.fromJson(responseBody);
      return estudiante;
    });

    return result.when((error) => Either.left(error),
        (estudiante) => Either.right(estudiante));
  }
}

@riverpod
StudentRepository studentRepository(StudentRepositoryRef ref, String token) {
  return StudentRepository(
      ref.watch(HttpProvider(baseUrl: 'http://192.168.86.1:8080/')));
}
