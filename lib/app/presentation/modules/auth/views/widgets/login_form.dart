import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sprinf_app/app/presentation/global/components/my_button.dart';
import 'package:sprinf_app/app/presentation/global/components/my_textfield.dart';

class LoginBodyScreen extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBodyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            repeat: ImageRepeat.repeat,
            image: AssetImage('assets/images/background.png'),
          )),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
            shrinkWrap: true,
            reverse: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 535,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: HexColor("#ffffff"),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                          child: Column(
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 0, 20),
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
                                      prefixIcon:
                                          const Icon(Icons.mail_outline),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyButton(
                                      onPressed: () => (),
                                      buttonText: 'Ingresar',
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -200),
                        child: Image.asset(
                          'assets/images/logo-2.png',
                          scale: .8,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
