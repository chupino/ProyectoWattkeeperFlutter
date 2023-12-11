import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/components/notifications/notificationsBuilder.dart';
import 'package:wattkeeperr/controllers/NotificationController.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Notification.dart';
import 'package:wattkeeperr/providers/NotificationsProvider.dart';
import 'package:web_socket_channel/io.dart';

class NotificationsScheme extends StatefulWidget {
  final String token;
  final int cantidad;
  const NotificationsScheme(
      {super.key, required this.token, required this.cantidad});

  @override
  State<NotificationsScheme> createState() => _NotificationsSchemeState();
}

class _NotificationsSchemeState extends State<NotificationsScheme> {
  late final IOWebSocketChannel channel;
  int notificacionesTotal = 0;
  bool isInitialize = false;
  final controllerNotificaciones = NotificationController();
  late List<NotificationModel> notis;
  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      final NotificationModel notiNew =
          NotificationModel.fromJson(data["data"]);
      setState(() {
        notificacionesTotal++;
        notis.add(notiNew);
      });
    });
  }

  void initAsync() async {
    notis = await controllerNotificaciones.getNotifications(widget.token);
    notificacionesTotal = notis.length;
    setState(() {
      isInitialize = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/notificaciones');
    initAsync();
    streamListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsProvider>(builder: (context, notifier, child) {
      return isInitialize
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text.rich(TextSpan(
                            text: "Recibidas",
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                  text:
                                      "(${notificacionesTotal - notifier.notificacionesLeidas})",
                                  style: Theme.of(context).textTheme.bodyLarge)
                            ])),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                          child: Text(
                            'Marcar Como Leidos',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                          onPressed: () {
                            notifier.actualizarNotificacionesLeidas(
                                notificacionesTotal);
                          },
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  NotificationsBuilder(
                      token: widget.token, notificaciones: notis),
                ],
              ),
            )
          : LoadingAnimation();
    });
  }
}
