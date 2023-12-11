import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/forms/emailTextFormField.dart';
import 'package:wattkeeperr/components/forms/passwordField.dart';
import 'package:wattkeeperr/components/buttons/loginButton.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo_icon.png'),
                  Text(
                    'WattKeeper',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 45),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Theme.of(context).cardColor.withOpacity(0.9999)),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Iniciar Sesión',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Correo Electronico',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      EmailTextFormField(
                        hintText: 'Correo',
                        labelText: 'Correo',
                        icon: Icons.email,
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Contraseña',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      PasswordField(
                        hintText: 'Contraseña',
                        labelText: 'Contraseña',
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Introduzca su contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          LoginButton(
                            formKey: formKey,
                            emailController: emailController,
                            passwordController: passwordController,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: 'No tienes cuenta? ',
                            style: Theme.of(context).textTheme.labelMedium,
                            children: [
                              TextSpan(
                                  text: 'Crea una',
                                  style: Theme.of(context).textTheme.labelLarge,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      
                                      Navigator.pushNamed(context, '/register');
                                    }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
