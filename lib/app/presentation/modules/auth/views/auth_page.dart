import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/presentation/modules/auth/controller/auth_controller.dart';
import 'package:sprinf_app/app/presentation/modules/auth/views/widgets/login_form.dart';

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
        return LoginBodyScreen();
      },
    );
  }
}
