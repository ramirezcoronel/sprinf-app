import 'package:flutter/material.dart';
import 'package:sprinf_app/app/presentation/modules/auth/views/auth_page.dart';
import 'package:sprinf_app/app/presentation/modules/home/views/home_page.dart';
import 'package:sprinf_app/routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // verificar si el usuario ha iniciado sesion
    if (false) {
      return HomePage();
    } else {
      return AuthPage();
    }
  }
}
