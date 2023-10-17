import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprinf_app/app/domain/model/student.dart';
import 'package:sprinf_app/app/presentation/modules/student/controller/search_student_controller.dart';
import 'package:sprinf_app/routes/routes.dart';
import 'package:ternav_icons/ternav_icons.dart';

class SearchStudents extends ConsumerWidget {
  const SearchStudents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchStudentControllerProvider);

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
      body: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
          data: (data) {
            if (data == null) return Text('No hay estudiantes');
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
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: 'Buscar Estudiante',
                              border: InputBorder.none),
                          onChanged: (value) => searchStudents(value, data),
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
                  child: searchResult.isNotEmpty || controller.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, i) {
                            return Card(
                              margin: const EdgeInsets.all(0.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                    // backgroundImage: NetworkImage(
                                    //   searchResult[i].profileUrl,
                                    // ),
                                    ),
                                title: Text(
                                    '${searchResult[i]!.nombre} ${searchResult[i]!.apellido}'),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.all(0.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.studentsDetails,
                                      arguments: index);
                                  print(
                                      'Navegar a pagina de estudiante $index');
                                },
                                leading: CircleAvatar(
                                  child: Icon(TernavIcons.lightOutline.profile),
                                  // backgroundImage: NetworkImage(
                                  //   _userDetails[index].profileUrl,
                                  // ),
                                ),
                                title: Text(
                                    '${data[index]!.nombre} ${data[index]!.apellido}'),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }),
    );
  }
}
