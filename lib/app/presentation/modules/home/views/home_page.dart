import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprinf_app/app/data/services/local/session_service.dart';
import 'package:sprinf_app/app/presentation/global/components/my_button.dart';

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
          if (!await directory.exists())
            directory = await getExternalStorageDirectory();
        }
      } catch (err, stack) {
        print("Cannot get download folder path");
      }
      return directory?.path;
    }

    final user = ref.watch(getUserProvider);
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: user.when(
                    error: (error, _) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                    data: (data) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Bienvenido!'),
                          MyButton(
                              onPressed: () async {
                                String? token = await ref
                                    .read(sessionServiceProvider)
                                    .token;

                                String? downloadPath = await getDownloadPath();
                                if (downloadPath == null) return false;
                              },
                              buttonText: 'Descargar Reporte')
                        ],
                      );
                    }))));
  }
}
