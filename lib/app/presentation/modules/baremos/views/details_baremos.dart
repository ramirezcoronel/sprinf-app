import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprinf_app/app/domain/model/indicador.dart';
import 'package:sprinf_app/app/presentation/modules/baremos/controller/baremos_details_controller.dart';
import 'package:sprinf_app/app/presentation/modules/projects/controller/details_controller.dart';
import 'package:ternav_icons/ternav_icons.dart';

class BaremosDetails extends ConsumerWidget {
  const BaremosDetails(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baremos = ref.watch(baremosDetailsControllerProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Baremos'),
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: baremos.when(
                  error: (error, __) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (data) {
                    if (data == null) {
                      return const Text('Proyecto no encontrado');
                    } else {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child:
                                        Icon(TernavIcons.lightOutline.profile),
                                  ),
                                  title: Text(
                                      '${data[i].nombreTrayecto} - ${data[i].nombreFase}'),
                                ),
                              ),
                              SizedBox(height: 10),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: data[i].baremos!.length,
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      children: [
                                        Card(
                                          margin: const EdgeInsets.all(0.0),
                                          child: ListTile(
                                            title: Text(
                                                '${data[i].baremos![index].nombre}'),
                                            subtitle: Text(
                                                '${data[i].baremos![index].dimensiones} dimensiones'),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: data[i]
                                              .baremos![index]
                                              .infoDimensiones!
                                              .length,
                                          itemBuilder: (context, ind) {
                                            final dimension = data[i]
                                                .baremos![index]
                                                .infoDimensiones![ind];

                                            return Column(
                                              children: [
                                                Card(
                                                  margin:
                                                      const EdgeInsets.all(0.0),
                                                  child: ListTile(
                                                    title: Text(
                                                        '${dimension.nombre}'),
                                                    subtitle: Text(
                                                        (dimension.grupal == '0'
                                                            ? 'Individual'
                                                            : 'Grupal')),
                                                  ),
                                                ),
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount: dimension
                                                        .indicadores!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final indicador =
                                                          dimension
                                                                  .indicadores![
                                                              index];

                                                      return Card(
                                                        child: ListTile(
                                                          title: Text(
                                                              '${indicador.nombre}'),
                                                          subtitle: Text(
                                                              "Ponderación: ${indicador.ponderacion}"),
                                                        ),
                                                      );
                                                    })
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }))
                            ],
                          );
                        },
                      );
                    }
                  }))
        ],
      )),
    );
  }
}
