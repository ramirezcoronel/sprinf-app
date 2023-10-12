import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserProvider);
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: user.when(
                    error: (error, _) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                    data: (data) {
                      return Text('Bienvenido ${data.nombre}!');
                    }))));
  }
}
