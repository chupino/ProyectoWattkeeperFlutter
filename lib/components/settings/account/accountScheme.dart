import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/buttons/customButton.dart';
import 'package:wattkeeperr/components/forms/datePickerTextField.dart';
import 'package:wattkeeperr/components/forms/textFieldCustom.dart';
import 'package:wattkeeperr/components/home/errorScreen.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/models/User.dart';
import 'package:wattkeeperr/pages/editPasswordPage.dart';

class AccountScheme extends StatefulWidget {
  final String token;
  const AccountScheme({super.key, required this.token});

  @override
  State<AccountScheme> createState() => _AccountSchemeState();
}

class _AccountSchemeState extends State<AccountScheme> {
  User? user;
  final controller = SessionController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController fecNacController = TextEditingController();
  bool isInitialize = false;
  bool loading = true;
  bool loadingError = false;
  bool showEditButton = false;
  Map<TextEditingController, String> initialValues = {};

  initData(bool reload) async {
    setState(() {
      isInitialize = false;
      loading = true;
      loadingError = false;
    });
    try {
      await controller.getDataUser(widget.token).then((value) {
        user = value;
      }).timeout(Duration(seconds: 10));
      nameController.text = user!.nombres;
      emailController.text = user!.email;
      lastnameController.text = user!.apellidos;
      fecNacController.text = user!.fechaNacimiento;

      initialValues[nameController] = user!.nombres;
      initialValues[emailController] = user!.email;
      initialValues[lastnameController] = user!.apellidos;
      initialValues[fecNacController] = user!.fechaNacimiento;

      nameController.addListener(updateShowEditButton);
      lastnameController.addListener(updateShowEditButton);
      emailController.addListener(updateShowEditButton);
      fecNacController.addListener(updateShowEditButton);

      setState(() {
        isInitialize = true;
        loadingError = false;
        loading = false;
      });
    } catch (e) {
      setState(() {
        isInitialize = true;
        loadingError = true;
        loading = false;
      });
      print("Se produjo un error: $e");
    }
  }

  void updateShowEditButton() {
    setState(() {
      showEditButton = nameController.text != initialValues[nameController] ||
          lastnameController.text != initialValues[lastnameController] ||
          emailController.text != initialValues[emailController] ||
          fecNacController.text != initialValues[fecNacController];
    });
  }

  Future<void> handleRefresh() async {
    await initData(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData(false);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return loading
        ? LoadingAnimation()
        : loadingError
            ? ErrorScreen(reload: handleRefresh)
            : isInitialize
                ? SingleChildScrollView(
                    child: Stack(
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
                          child: Form(
                            key: formKey,
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
                                  "${nameController.text} ${lastnameController.text}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFieldCustom(
                                    hintText: 'Nombre',
                                    labelText: 'Nombre',
                                    controller: nameController,
                                    icon: Icons.person),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFieldCustom(
                                  hintText: 'Apellidos',
                                  labelText: 'Apellidos',
                                  icon: Icons.person_4,
                                  controller: lastnameController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFieldCustom(
                                  hintText: 'Correo',
                                  labelText: 'Correo',
                                  icon: Icons.email,
                                  controller: emailController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                DatePickerTextField(
                                  hintText: 'Fecha de Nacimiento',
                                  controller: fecNacController,
                                  icon: Icons.date_range,
                                  labelText: 'Fecha de Nacimiento',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Ingresa una fecha correcta";
                                    }
                                    DateTime fechaIngresada =
                                        DateTime.parse(value);
                                    DateTime ahora = DateTime.now();
                                    // Elimina la hora de la fecha actual para comparar solo las fechas
                                    ahora = DateTime(
                                        ahora.year, ahora.month, ahora.day);
                                    if (!fechaIngresada.isBefore(ahora)) {
                                      return "La fecha debe ser anterior a la fecha actual";
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.datetime,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                showEditButton
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          padding:
                                                              MaterialStatePropertyAll(
                                                                  EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              20)),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Colors
                                                                      .deepPurple)),
                                                      onPressed: () async {
                                                        if(formKey.currentState!.validate()){
await controller
                                                            .updateDataUser(
                                                                widget.token,
                                                                nameController
                                                                    .text,
                                                                lastnameController
                                                                    .text,
                                                                fecNacController
                                                                    .text,
                                                                emailController
                                                                    .text)
                                                            .then((value) {
                                                          if (value == true) {
                                                            setState(() {
                                                              initialValues[
                                                                      nameController] =
                                                                  nameController
                                                                      .text;
                                                              initialValues[
                                                                      emailController] =
                                                                  emailController
                                                                      .text;
                                                              initialValues[
                                                                      lastnameController] =
                                                                  lastnameController
                                                                      .text;
                                                              initialValues[
                                                                      fecNacController] =
                                                                  fecNacController
                                                                      .text;
                                                              showEditButton =
                                                                  false;
                                                            });
                                                            final snackbar =
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    content:
                                                                        AwesomeSnackbarContent(
                                                                      contentType:
                                                                          ContentType
                                                                              .success,
                                                                      title:
                                                                          "Actualizado Correctamente",
                                                                      message:
                                                                          "Tus datos se actualizaron correctamente",
                                                                    ));
                                                            ScaffoldMessenger.of(
                                                                context)
                                                              ..hideCurrentSnackBar()
                                                              ..showSnackBar(
                                                                  snackbar);
                                                          } else {
                                                            final snackbar =
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    content:
                                                                        AwesomeSnackbarContent(
                                                                      contentType:
                                                                          ContentType
                                                                              .failure,
                                                                      title:
                                                                          "Algo salio mal",
                                                                      message:
                                                                          "No se pudo guardar tu información",
                                                                    ));
                                                            ScaffoldMessenger.of(
                                                                context)
                                                              ..hideCurrentSnackBar()
                                                              ..showSnackBar(
                                                                  snackbar);
                                                          }
                                                        }).catchError((e) {
                                                          final snackbar =
                                                              SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  content:
                                                                      AwesomeSnackbarContent(
                                                                    contentType:
                                                                        ContentType
                                                                            .failure,
                                                                    title:
                                                                        "Algo salio mal",
                                                                    message:
                                                                        "No se pudo guardar tu información",
                                                                  ));
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(
                                                                snackbar);
                                                        });
                                                        }
                                                        
                                                      },
                                                      child:
                                                          Text("Editar Campos")))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                padding: MaterialStatePropertyAll(
                                                    EdgeInsets.symmetric(
                                                        vertical: 20)),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color.fromARGB(
                                                            255, 86, 8, 74))),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PasswordEditPage(
                                                              token:
                                                                  widget.token)));
                                            },
                                            child: Text('Actualizar Contraseña')))
                                  ],
                                ),
                                Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                          text: 'Cerrar Sesión',
                                          onPressed: () {
                                            controller
                                                .logout(widget.token)
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
                        ),
                      ],
                    ),
                  )
                : LoadingAnimation();
  }
}
