import 'package:flutter/material.dart';
import 'package:sprinf_app/app/presentation/modules/auth/views/auth_page.dart';
import 'package:sprinf_app/app/presentation/modules/home/views/home_page.dart';
import 'package:sprinf_app/app/presentation/modules/projects/details.dart';
import 'package:sprinf_app/app/presentation/modules/projects/search.dart';
import 'package:sprinf_app/app/presentation/modules/splash/views/splash_screen.dart';
import 'package:sprinf_app/app/presentation/modules/student/details.dart';
import 'package:sprinf_app/app/presentation/modules/student/search.dart';
import 'package:sprinf_app/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashScreen(),
    Routes.login: (context) => const AuthPage(),
    Routes.home: (context) => const HomePage(),
    Routes.students: (context) => SearchStudents(),
    Routes.projects: (context) => SearchProjects(),
    Routes.projectsDetails: (context) {
      final int id = ModalRoute.of(context)!.settings.arguments as int;
      return Details(id);
    },
    Routes.studentsDetails: (context) {
      final String id = ModalRoute.of(context)!.settings.arguments as String;
      return StudentDetails(id);
    }
  };
}
