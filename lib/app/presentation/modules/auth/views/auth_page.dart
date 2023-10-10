import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/data/repositories/auth_repository.dart';
import 'package:sprinf_app/app/domain/either.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterLogin(
      savedEmail: 'root@gmail.com',
      savedPassword: 'secret',
      title: 'SPRINF',
      // logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: (LoginData data) async {
        Either<HttpFailure, String> result = await ref
            .read(authRepositoryProvider)
            .login(data.name, data.password);

        result.when((failure) => print(failure), (token) {
          if (kDebugMode) {
            print(token);
          }
        });
        return null;
      },
      onRecoverPassword: (_) => null,
      onSubmitAnimationCompleted: () => (),
    );
  }
}
