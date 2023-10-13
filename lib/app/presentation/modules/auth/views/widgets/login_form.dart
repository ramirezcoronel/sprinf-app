import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sprinf_app/app/data/http/http.dart';
import 'package:sprinf_app/app/presentation/global/components/my_button.dart';
import 'package:sprinf_app/app/presentation/global/components/my_textfield.dart';
import 'package:sprinf_app/app/presentation/modules/auth/controller/auth_controller.dart';

class LoginBodyScreen extends ConsumerWidget {
  final emailController = TextEditingController(text: 'root@gmail.com');
  final passwordController = TextEditingController(text: 'secret');

  LoginBodyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Iniciar Sesión",
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: HexColor("#024cb0"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Correo",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: HexColor("#8d8d8d"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                onChanged: (() {
                  // validateEmail(emailController.text);
                }),
                controller: emailController,
                hintText: "...",
                obscureText: false,
                prefixIcon: const Icon(Icons.mail_outline),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Contraseña",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: HexColor("#8d8d8d"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordController,
                hintText: "**************",
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              const SizedBox(
                height: 20,
              ),
              state.when(data: (data) {
                return MyButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;

                    await ref
                        .read(authControllerProvider.notifier)
                        .login(email: email, password: password);
                  },
                  buttonText: 'Ingresar',
                );
              }, error: (err, _) {
                return Column(
                  children: [
                    MyButton(
                      onPressed: () async {
                        String email = emailController.text;
                        String password = passwordController.text;

                        await ref
                            .read(authControllerProvider.notifier)
                            .login(email: email, password: password);
                      },
                      buttonText: 'Ingresar',
                    ),
                    (err is HttpFailure)
                        ? Text(
                            'Error ${err.statusCode.toString()}: ${err.exception.toString()}')
                        : const Text('Error inesperado')
                  ],
                );
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
