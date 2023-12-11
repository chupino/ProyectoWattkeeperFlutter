import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController, passwordController;
  const LoginButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoggining = false;
  @override
  Widget build(BuildContext context) {
    final controller = SessionController();
    return Expanded(
      child: !isLoggining
          ? ElevatedButton(
              onPressed: () async {
                if (widget.formKey.currentState!.validate()) {
                  setState(() {
                    isLoggining = true;
                  });
                  await controller
                      .login(widget.emailController.text,
                          widget.passwordController.text)
                      .then((value) {
                    if (value == true) {
                      final snackbar = SnackBar(
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            contentType: ContentType.success,
                            title: "Inicio de Sesión",
                            message: "Se inicio sesión correctamente",
                          ));
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackbar);
                      Navigator.pushReplacementNamed(context, '/navBarHome');
                    } else {
                      final snackbar = SnackBar(
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            contentType: ContentType.failure,
                            title: "Comprueba tus Credenciales",
                            message: "Tus credenciales son erroneas",
                          ));
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackbar);
                    }
                  }).catchError((value) {
                    final snackbar = SnackBar(
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          contentType: ContentType.failure,
                          title: "Algo ocurrio mal",
                          message: "Vuelve a intentarlo mas tarde",
                        ));
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackbar);
                  });
                  setState(() {
                    isLoggining = false;
                  });
                } else {
                  null;
                }
              },
              child: const Text(
                'Iniciar Sesión',
              ))
          : ElevatedButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 1, 33, 59))),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/loginLoading3.json',
                    height: 50,
                  ),
                  const Text(
                    'Iniciando Sesión...',
                  ),
                ],
              )),
    );
  }
}
