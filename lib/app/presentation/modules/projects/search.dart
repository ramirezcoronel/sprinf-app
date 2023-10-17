import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sprinf_app/app/data/repositories/project_repository.dart';
import 'package:sprinf_app/app/data/repositories/student_repository.dart';
import 'package:sprinf_app/app/presentation/modules/projects/controller/search_project_controller.dart';
import 'package:sprinf_app/app/presentation/modules/student/controller/search_student_controller.dart';
import 'package:sprinf_app/routes/routes.dart';
import 'package:ternav_icons/ternav_icons.dart';

class SearchProjects extends ConsumerWidget {
  const SearchProjects({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consulta = ref.watch(listarProyectosProvider);

    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyectos'),
        elevation: 0.0,
      ),
      body: consulta.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
          data: (data) {
            if (data == null) return const Text('No hay proyectos');

            final state = ref.watch(searchProjectControllerProvider(data));

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
                              hintText: 'Buscar Proyectos',
                              border: InputBorder.none),
                          onChanged: (value) {
                            ref
                                .read(searchProjectControllerProvider(data)
                                    .notifier)
                                .filter(data, value);
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            controller.clear();
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
                                  backgroundColor: HexColor("#024cb0"),
                                  child: Icon(TernavIcons.lightOutline.profile,
                                      color: Colors.white),
                                ),
                                title: Text('${data![i].nombre}}'),
                                subtitle: Text(
                                    "${data[i].nombreTrayecto} - ${data[i].comunidad} - ${data[i].tutorInNombre}"),
                                trailing: Icon(
                                    TernavIcons.lightOutline.arrow_right_1),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.projectsDetails,
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
