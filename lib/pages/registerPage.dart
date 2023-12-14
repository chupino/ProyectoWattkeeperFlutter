import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/buttons/registerButton.dart';
import 'package:wattkeeperr/components/forms/customTextFormField.dart';
import 'package:wattkeeperr/components/forms/datePickerTextField.dart';
import 'package:wattkeeperr/components/forms/emailTextFormField.dart';
import 'package:wattkeeperr/components/forms/passwordField.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordConfirmController =
        TextEditingController();
    final TextEditingController fecNacController = TextEditingController();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
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
            flex: 3,
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
                        'Registrarse',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Nombre',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      CustomTextFormField(
                        hintText: 'Nombre',
                        labelText: 'Nombre',
                        controller: nameController,
                        icon: Icons.person,
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Apellido',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      CustomTextFormField(
                        hintText: 'Apellido',
                        labelText: 'Apellido',
                        controller: lastNameController,
                        icon: Icons.person_2,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Fecha de Nacimiento',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      DatePickerTextField(
                          hintText: 'Fecha de Nacimiento',
                          labelText: 'Fecha de Nacimiento',
                          icon: Icons.date_range,
                          readOnly: false,
                          textInputType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ingresa una fecha correcta";
                            }
                            DateTime fechaIngresada = DateTime.parse(value);
                            DateTime ahora = DateTime.now();
                            // Elimina la hora de la fecha actual para comparar solo las fechas
                            ahora =
                                DateTime(ahora.year, ahora.month, ahora.day);
                            if (!fechaIngresada.isBefore(ahora)) {
                              return "La fecha debe ser anterior a la fecha actual";
                            }
                            return null;
                          },
                          controller: fecNacController),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Correo',
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
                          } else if (value.length < 8) {
                            return 'Su contraseña es muy corta';
                          } else if (value
                                  .compareTo(passwordConfirmController.text) !=
                              0) {
                            return 'La contraseña no coincide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Confirmar Contraseña',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      PasswordField(
                        hintText: 'Contraseña',
                        labelText: 'Contraseña',
                        controller: passwordConfirmController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Introduzca su contraseña';
                          } else if (value.length < 8) {
                            return 'Su contraseña es muy corta';
                          } else if (value.compareTo(passwordController.text) !=
                              0) {
                            return 'La contraseña no coincide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          RegisterButton(
                            formKey: formKey,
                            emailController: emailController,
                            passwordController: passwordController,
                            nameController: nameController,
                            lastNameController: lastNameController,
                            fecNacController: fecNacController,
                            passwordConfirmController:
                                passwordConfirmController,
                          )
                        ],
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
