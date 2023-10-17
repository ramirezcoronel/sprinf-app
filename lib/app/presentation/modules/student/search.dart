import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprinf_app/app/data/repositories/student_repository.dart';
import 'package:sprinf_app/app/domain/model/student.dart';
import 'package:sprinf_app/app/presentation/modules/student/controller/search_student_controller.dart';
import 'package:sprinf_app/routes/routes.dart';
import 'package:ternav_icons/ternav_icons.dart';

class SearchStudents extends ConsumerWidget {
  const SearchStudents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consulta = ref.watch(listarEstudiantesProvider);

    TextEditingController controller = TextEditingController();
    List<Student?> searchResult = [];

    searchStudents(String text, List<Student?> estudiantes) async {
      searchResult.clear();
      if (text.isEmpty || estudiantes.isNotEmpty) {
        return estudiantes;
      }

      for (var userDetail in estudiantes) {
        if (userDetail!.nombre.contains(text) ||
            userDetail.apellido.contains(text)) searchResult.add(userDetail);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
        elevation: 0.0,
      ),
      body: consulta.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
          data: (data) {
            if (data == null) return Text('No hay estudiantes');

            final state = ref.watch(searchStudentControllerProvider(data));

            return Column(
              children: <Widget>[
                Container(
                  color: HexColor('#0249a7'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.search),
                        title: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Buscar Estudiante',
                              border: InputBorder.none),
                          onChanged: (value) {
                            ref
                                .read(searchStudentControllerProvider(data)
                                    .notifier)
                                .filter(data, value);
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            controller.clear();
                            searchStudents('', data);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: state.when(
                      data: (data) {
                        return ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (context, i) {
                            return Card(
                              margin: const EdgeInsets.all(0.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Icon(TernavIcons.lightOutline.profile),
                                ),
                                title: Text(
                                    '${data![i].nombre} ${data[i].apellido}'),
                                subtitle: Text("C.I. ${data![i].cedula}"),
                                trailing: Icon(
                                    TernavIcons.lightOutline.arrow_right_1),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.studentsDetails,
                                      arguments: data[i].id);
                                },
                              ),
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator())),
                ),
              ],
            );
          }),
    );
  }
}
