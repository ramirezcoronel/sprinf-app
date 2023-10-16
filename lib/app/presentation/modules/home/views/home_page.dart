import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/presentation/global/components/my_button.dart';
import 'package:sprinf_app/app/presentation/global/constant.dart';
import 'package:sprinf_app/app/presentation/global/drawer.dart';
import 'package:sprinf_app/app/presentation/modules/splash/views/contoller/splash_controller.dart';
import 'package:sprinf_app/routes/routes.dart';
import 'package:ternav_icons/ternav_icons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<String?> getDownloadPath() async {
      Directory? directory;
      try {
        if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        } else {
          directory = Directory('/storage/emulated/0/Download');
          // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
          // ignore: avoid_slow_async_io
          if (!await directory.exists()) {
            directory = await getExternalStorageDirectory();
          }
        }
      } catch (err) {
        print("Cannot get download folder path");
      }
      return directory?.path;
    }

    final user = ref.watch(getUserProvider);
    return Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        drawer: const SideMenu(),
        body: SafeArea(
            child: user.when(
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (data) {
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        Container(
                            height: 200,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              // repeat: ImageRepeat.repeat,
                              image: AssetImage(
                                  'assets/images/dashboard-background.png'),
                            ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Hola ",
                                    style: const TextStyle(
                                        color: kDarkBlue, fontSize: 20),
                                    children: [
                                      TextSpan(
                                        text: data.nombre,
                                        style: const TextStyle(
                                            color: kDarkBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const TextSpan(
                                        text: ", Bienvenido de vuelta!",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.projects);
                                    },
                                    leading: Icon(
                                        TernavIcons.lightOutline.programming),
                                    title: Text('Proyectos'),
                                    trailing: Icon(
                                        TernavIcons.lightOutline.arrow_right_1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Card(
                                  child: ListTile(
                                    leading:
                                        Icon(TernavIcons.lightOutline.profile),
                                    title: Text('Estudiantes'),
                                    trailing: Icon(
                                        TernavIcons.lightOutline.arrow_right_1),
                                  ),
                                ),
                                MyButton(
                                    onPressed: () async {
                                      String? token = await ref
                                          .read(sessionServiceProvider)
                                          .token;

                                      String? downloadPath =
                                          await getDownloadPath();
                                      if (downloadPath == null) return false;

                                      await FlutterDownloader.enqueue(
                                        url:
                                            'http://192.168.0.105:8080/api/project-report/TR4',
                                        headers: {
                                          'Authorization': 'Bearer $token'
                                        }, // optional: header send with url (auth token etc)
                                        fileName: 'reporte-proyectos.xlsx',
                                        savedDir: downloadPath,
                                        showNotification:
                                            true, // show download progress in status bar (for Android)
                                        openFileFromNotification:
                                            true, // click on notification to open downloaded file (for Android)
                                      );
                                    },
                                    buttonText: 'Descargar Reporte'),
                                MyButton(
                                    onPressed: () async {
                                      await ref
                                          .read(
                                              splashControllerProvider.notifier)
                                          .logout();
                                    },
                                    buttonText: 'Cerrar Sesión'),
                              ],
                            )),
                      ]));
                })));
  }
}
