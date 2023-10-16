import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprinf_app/app/presentation/modules/projects/controller/details_controller.dart';
import 'package:sprinf_app/app/presentation/modules/student/controller/student_details_controller.dart';
import 'package:ternav_icons/ternav_icons.dart';

import '../../global/constant.dart';

class StudentDetails extends ConsumerWidget {
  const StudentDetails(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estudiante = ref.watch(studentDetailsControllerProvider(1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('estudiante'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: estudiante.when(
                  error: (error, __) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (data) {
                    if (data == null) {
                      return const Text('estudiante no encontrado');
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            // color: HexColor('#0249a7'),
                            child: ListTile(
                              title: Text(
                                '${data.nombre} ${data.apellido}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: HexColor("#ffffff"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Card(
                            // color: HexColor('#0249a7'),
                            child: ListTile(
                              title: Text(
                                '${data.nombre} ${data.apellido}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: HexColor("#ffffff"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
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
