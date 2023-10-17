import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/domain/model/fase.dart';

import '../../domain/either.dart';

part 'baremos_repository.g.dart';

class BaremosRepository {
  BaremosRepository(this._http);
  final Http _http;

  Future<Either<HttpFailure, List<Fase>?>> obtener(String id) async {
    final result = await _http.request('api/baremos',
        body: {
          'data': {'codigo': id}
        },
        useToken: true,
        method: HttpMethod.post, onSucess: (responseBody) {
      if (responseBody is Iterable) {
        List<Fase> resultado =
            responseBody.map((fase) => Fase.fromJson(fase)).toList();
        return resultado;
      }
    });

    return result.when(
        (error) => Either.left(error), (fase) => Either.right(fase));
  }
}

@riverpod
BaremosRepository baremosRepository(BaremosRepositoryRef ref) {
  return BaremosRepository(
      ref.watch(HttpProvider(baseUrl: 'http://192.168.86.1:8080/')));
}
