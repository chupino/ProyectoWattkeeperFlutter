import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/components/navBar/navBar.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:wattkeeperr/controllers/NotificationController.dart';
import 'package:wattkeeperr/models/Notification.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final String token;

  const NotificationCard(
      {required this.notification, super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final controller = NotificationController();
    final groupController = GroupController();
    return GestureDetector(
      onTap: () async {
        print(notification.id);
        showDialog(
          context: context,
          builder: (context) {
            return FutureBuilder(
              future: controller.getNotification(token, notification.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(snapshot.data!.asunto),
                        Lottie.asset(
                            snapshot.data!.remitente != null
                                ? 'assets/animations/invitation.json'
                                : 'assets/animations/alert.json',
                            repeat:
                                snapshot.data!.remitente != null ? false : true,
                            height: 100),
                        Text(
                          snapshot.data!.descripcion,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        snapshot.data!.datosEnvio != null &&
                                snapshot.data!.datosEnvio!.tokenUrl != null &&
                                snapshot.data!.datosEnvio!.tokenUrl.isNotEmpty
                            ? Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        groupController
                                            .joinGroup(
                                                token,
                                                snapshot
                                                    .data!.datosEnvio!.tokenUrl)
                                            .then((value) {
                                          if (value == true) {
                                            final snackbar = SnackBar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: AwesomeSnackbarContent(
                                                contentType:
                                                    ContentType.success,
                                                title: "Te uniste al grupo",
                                                message:
                                                    "Se te ha unido al grupo correctamente",
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(snackbar);
                                          } else {
                                            final snackbar = SnackBar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: AwesomeSnackbarContent(
                                                contentType:
                                                    ContentType.failure,
                                                title: "Ocurrió algo mal",
                                                message: "Algo salió mal",
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(snackbar);
                                          }
                                        }).catchError((e) {
                                          final snackbar = SnackBar(
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              contentType: ContentType.failure,
                                              title: "Ocurrió algo mal",
                                              message: "Algo salió mal",
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackbar);
                                        });
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NavBarWattKeeper(
                                                    initialIndex: 1),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: Text('Unirse'),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  );
                } else {
                  return LoadingAnimation();
                }
              },
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor),
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  notification.asunto,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    notification.formattedFechaEnvio2(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey),
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(notification.descripcion,
              style: Theme.of(context).textTheme.bodySmall)
        ]),
      ),
    );
  }
}
