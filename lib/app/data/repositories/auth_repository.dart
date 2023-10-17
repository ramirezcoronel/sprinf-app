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
      return responseBody;
    });

    return result.when((failure) => Either.left(failure),
        (encryptedResponse) => Either.right(encryptedResponse));
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
      ref.watch(HttpProvider(baseUrl: 'http://192.168.86.1:8080/')));
}
