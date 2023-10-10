import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
        () => ref.watch(authRepositoryProvider).login(email, password));
  }
}
