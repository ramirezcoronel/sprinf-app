import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/presentation/modules/auth/controller/auth_controller.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadBundle = ref.watch(loadBundleProvider);

    return loadBundle.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (data) {
        return FlutterLogin(
          savedEmail: 'root@gmail.com',

          savedPassword: 'secret',
          title: 'SPRINF',
          // logo: AssetImage('assets/images/ecorp-lightblue.png'),
          onLogin: (LoginData data) async {
            await ref
                .read(authControllerProvider.notifier)
                .login(email: data.name, password: data.password);
            return null;
          },
          onRecoverPassword: (_) => null,
          onSubmitAnimationCompleted: () => (),
        );
      },
    );
  }
}
