import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/presentation/modules/auth/views/auth_page.dart';
import 'package:sprinf_app/app/presentation/modules/home/views/home_page.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // verificar si el usuario ha iniciado sesion
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return isLoggedIn.when(
        error: (e, s) {
          return const AuthPage();
        },
        loading: () => const CircularProgressIndicator(),
        data: (data) {
          if (data) {
            return const HomePage();
          } else {
            return const AuthPage();
          }
        });
  }
}
