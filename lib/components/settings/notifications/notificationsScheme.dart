import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/home/errorScreen.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/components/settings/switchCustom.dart';
import 'package:wattkeeperr/components/settings/tileCustom.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/models/User.dart';

class NotificationsSettingsScheme extends StatefulWidget {
  final String token;
  const NotificationsSettingsScheme({super.key, required this.token});

  @override
  State<NotificationsSettingsScheme> createState() =>
      _NotificationsSettingsSchemeState();
}

class _NotificationsSettingsSchemeState
    extends State<NotificationsSettingsScheme> {
  bool isInitialize = false;
  bool loading = true;
  bool loadingError = false;
  bool alertaGrupos = true;
  bool alertaDispositivos = true;
  bool alertaRecompensas = true;
  User? user;
  final controller = SessionController();

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

      alertaDispositivos = user!.configuracion.alertaLimiteDispositivo;
      alertaGrupos = user!.configuracion.alertasLimiteGrupo;
      alertaRecompensas = user!.configuracion.alertaRecompensa;
      setState(() {
        isInitialize = true;
        loadingError = false;
        loading = false;
      });
    } catch (e) {
      setState(() {
        isInitialize = true;
        loading = false;
        loadingError = true;
      });
    }
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
    return loading
        ? LoadingAnimation()
        : loadingError
            ? ErrorScreen(reload: handleRefresh)
            : isInitialize
                ? RefreshIndicator(
                    onRefresh: handleRefresh,
                    child: ListView(
                      children: [
                        TileCustom(
                            icon: Icons.group,
                            widgetAdj: SwitchCustom(
                                value: alertaGrupos,
                                onToggle: (value) async {
                                  await controller
                                      .updateConfiguration(
                                          widget.token,
                                          !alertaGrupos,
                                          alertaDispositivos,
                                          alertaRecompensas)
                                      .then((value) {
                                    if (value == true) {
                                      setState(() {
                                        alertaGrupos = !alertaGrupos;
                                      });
                                      final snackbar = SnackBar(
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            contentType: ContentType.success,
                                            title: "Actualizado Correctamente",
                                            message:
                                                "La configuración se guardo correctamente",
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
                                            message:
                                                "No se pudo guardar tu configuración",
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
                                          message:
                                              "No se pudo guardar tu configuración",
                                        ));
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackbar);
                                  });
                                }),
                            title: "Alerta por superación de limite de grupos"),
                        TileCustom(
                            icon: Icons.device_unknown,
                            widgetAdj: SwitchCustom(
                                value: alertaDispositivos,
                                onToggle: (value) async {
                                  await controller
                                      .updateConfiguration(
                                          widget.token,
                                          alertaGrupos,
                                          !alertaDispositivos,
                                          alertaRecompensas)
                                      .then((value) {
                                    if (value == true) {
                                      setState(() {
                                        alertaDispositivos =
                                            !alertaDispositivos;
                                      });
                                      final snackbar = SnackBar(
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            contentType: ContentType.success,
                                            title: "Actualizado Correctamente",
                                            message:
                                                "La configuración se guardo correctamente",
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
                                            message:
                                                "No se pudo guardar tu configuración",
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
                                          message:
                                              "No se pudo guardar tu configuración",
                                        ));
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackbar);
                                  });
                                }),
                            title:
                                "Alerta por superacion de limite de dispositivos"),
                        TileCustom(
                            icon: Icons.redeem,
                            widgetAdj: SwitchCustom(
                                value: alertaRecompensas,
                                onToggle: (value) async {
                                  await controller
                                      .updateConfiguration(
                                          widget.token,
                                          alertaGrupos,
                                          alertaDispositivos,
                                          !alertaRecompensas)
                                      .then((value) {
                                    if (value == true) {
                                      setState(() {
                                        alertaRecompensas = !alertaRecompensas;
                                      });
                                      final snackbar = SnackBar(
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            contentType: ContentType.success,
                                            title: "Actualizado Correctamente",
                                            message:
                                                "La configuración se guardo correctamente",
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
                                            message:
                                                "No se pudo guardar tu configuración",
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
                                          message:
                                              "No se pudo guardar tu configuración",
                                        ));
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackbar);
                                  });
                                }),
                            title: "Alerta por recompensas"),
                      ],
                    ),
                  )
                : LoadingAnimation();
  }
}
