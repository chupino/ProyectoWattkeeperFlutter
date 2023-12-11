import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/buttons/customButton.dart';
import 'package:wattkeeperr/components/forms/datePickerTextField.dart';
import 'package:wattkeeperr/components/forms/textFieldCustom.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/components/settings/account/headerAccount.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/models/User.dart';

class AccountPage extends StatelessWidget {
  final String token;
  final controller = SessionController();
  AccountPage({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const HeaderAccount(),
        SliverFillRemaining(
            child: FutureBuilder(
                future: controller.getDataUser(token),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimation();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final User user = snapshot.data!;
                    final TextEditingController nameController =
                        TextEditingController(text: user.nombres);
                    final TextEditingController emailController =
                        TextEditingController(text: user.email);
                    final TextEditingController lastnameController =
                        TextEditingController(text: user.apellidos);
                    final TextEditingController fecNacController =
                        TextEditingController(text: user.getFormatedFecNac());
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Image.asset('assets/images/user.png'),
                                  ),
                                  radius: 100),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${snapshot.data!.nombres} ${snapshot.data!.apellidos}",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldCustom(
                                  readOnly: true,
                                  hintText: 'Nombre',
                                  labelText: 'Nombre',
                                  controller: nameController,
                                  icon: Icons.person),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFieldCustom(
                                readOnly: true,
                                hintText: 'Apellidos',
                                labelText: 'Apellidos',
                                icon: Icons.person_4,
                                controller: lastnameController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFieldCustom(
                                readOnly: true,
                                hintText: 'Correo',
                                labelText: 'Correo',
                                icon: Icons.email,
                                controller: emailController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DatePickerTextField(
                                readOnly: true,
                                hintText: 'Fecha de Nacimiento',
                                controller: fecNacController,
                                icon: Icons.date_range,
                                labelText: 'Fecha de Nacimiento',
                                textInputType: TextInputType.datetime,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                        text: 'Cerrar Sesión',
                                        onPressed: () {
                                          controller
                                              .logout(token)
                                              .then((value) {
                                            final snackbar = SnackBar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  contentType: ContentType.help,
                                                  title: "Saliste",
                                                  message:
                                                      "Se cerró sesión correctamente",
                                                ));
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(snackbar);
                                            Navigator.pushReplacementNamed(
                                                context, '/login');
                                          });
                                        }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    print(snapshot.error);
                    return const Text("Algo ocurrio brutalmente mal");
                  }
                }))
      ],
    ));
  }
}
