import 'package:flutter/material.dart';
import 'package:sprinf_app/app/presentation/modules/auth/views/auth_page.dart';
import 'package:sprinf_app/app/presentation/modules/home/views/home_page.dart';
import 'package:sprinf_app/app/presentation/modules/projects/search.dart';
import 'package:sprinf_app/app/presentation/modules/splash/views/splash_screen.dart';
import 'package:sprinf_app/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashScreen(),
    Routes.login: (context) => const AuthPage(),
    Routes.home: (context) => const HomePage(),
    Routes.projects: (context) => SearchProjects(),
  };
}
