import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprinf_app/app/presentation/modules/projects/controller/details_controller.dart';
import 'package:ternav_icons/ternav_icons.dart';

import '../../global/constant.dart';

class Details extends ConsumerWidget {
  const Details(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proyecto = ref.watch(detailsControllerProvider(1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: proyecto.when(
                  error: (error, __) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (data) {
                    if (data == null) {
                      return const Text('Proyecto no encontrado');
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.nombre,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: HexColor("#000"),
                            ),
                          ),
                          Text(
                            '${data.nombreTrayecto} - ${data.nombreFase}',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: HexColor("#000"),
                            ),
                          ),
                          Text(
                            '${data.fechaInicio}/${data.fechaCierre}',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: HexColor("#000"),
                            ),
                          ),
                        ],
                      );
                    }
                  })),
        ),
      ),
    );
  }
}
