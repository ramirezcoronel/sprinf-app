import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprinf_app/app/presentation/modules/projects/controller/details_controller.dart';
import 'package:ternav_icons/ternav_icons.dart';

class Details extends ConsumerWidget {
  const Details(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proyecto = ref.watch(detailsControllerProvider(1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyectos'),
        elevation: 0.0,
      ),
      body: proyecto.when(
          error: (error, __) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
          data: (data) {
            if (data == null) {
              return const Text('Proyecto no encontrado');
            } else {
              return Text(data.nombre);
            }
          }),
    );
  }
}
