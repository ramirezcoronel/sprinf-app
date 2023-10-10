import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/http/http.dart';

import '../../domain/either.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._http);
  final Http _http;

  Future<Either<HttpFailure, String>> login(String encryptedData) async {
    final result = await _http.request('api/auth/login',
        method: HttpMethod.post,
        body: {"data": encryptedData}, onSucess: (responseBody) {
      // TODO: desencriptar response
      final json = responseBody;
      return (responseBody == null) ? '' : json['data'] as String;
    });

    return result.when(
        (failure) => Either.left(failure), (token) => Either.right(token));
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  // TODO: obtener baseURL desde una variable de entorno
  return AuthRepository(ref
      .watch(HttpProvider(baseUrl: 'http://192.168.0.108:8080/', token: '')));
}
