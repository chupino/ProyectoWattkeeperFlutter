import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/forms/passwordField.dart';
import 'package:wattkeeperr/components/forms/textFieldCustom.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/pages/loginPage.dart';

class PasswordEditPage extends StatelessWidget {
  final String token;
  const PasswordEditPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();
    final controller = SessionController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Contraseña"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              PasswordField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduzca su contraseña';
                  } else if (value.length < 8) {
                    return 'Su contraseña es muy corta';
                  }
                  return null;
                },
                controller: currentPasswordController,
                hintText: 'Contraseña Actual',
                labelText: 'Contraseña Actual',
              ),
              SizedBox(
                height: 10,
              ),
              PasswordField(
                hintText: 'Nueva Contraseña',
                labelText: 'Nueva Contraseña',
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduzca su contraseña';
                  } else if (value.length < 8) {
                    return 'Su contraseña es muy corta';
                  } else if (value
                          .compareTo(confirmNewPasswordController.text) !=
                      0) {
                    return 'La contraseña no coincide';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              PasswordField(
                hintText: 'Confirme Nueva Contraseña',
                labelText: 'Confirme Nueva Contraseña',
                controller: confirmNewPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduzca su contraseña';
                  } else if (value.length < 8) {
                    return 'Su contraseña es muy corta';
                  } else if (value.compareTo(newPasswordController.text) != 0) {
                    return 'La contraseña no coincide';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 20)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await controller
                                  .updatePassword(
                                      token,
                                      currentPasswordController.text,
                                      newPasswordController.text,
                                      confirmNewPasswordController.text)
                                  .then((value) {
                                if (value == true) {
                                  controller.deleteToken(token);
                                  controller.deleteToken(token);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      (route) => false);
                                  final snackbar = SnackBar(
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        contentType: ContentType.success,
                                        title: "Actualizado Correctamente",
                                        message:
                                            "Tu contraseña se actualizo correctamente",
                                      ));
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackbar);
                                } else {
                                  final snackbar = SnackBar(
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        contentType: ContentType.failure,
                                        title: "Algo salio mal",
                                        message: "Verifica tus datos",
                                      ));
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackbar);
                                }
                              }).catchError((e) {
                                final snackbar = SnackBar(
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      contentType: ContentType.failure,
                                      title: "Algo salio mal",
                                      message: "Verifica tus datos",
                                    ));
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackbar);
                              });
                            }
                          },
                          child: Text("Actualizar Contraseña")))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
