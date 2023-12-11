import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wattkeeperr/components/home/welcomeHome.dart';
import 'package:wattkeeperr/controllers/NotificationController.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/User.dart';
import 'package:wattkeeperr/pages/notificationsPage.dart';
import 'package:wattkeeperr/providers/NotificationsProvider.dart';
import 'package:web_socket_channel/io.dart';

class HeaderHome extends StatefulWidget {
  final String token;
  HeaderHome({super.key, required this.token});

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  final controller = SessionController();
  final controllerNotificaciones = NotificationController();
  bool isInitialize = false;
  int notificacionesSinVer = 0;
  int notificacionesTotal = 0;
  late User user;
  late final IOWebSocketChannel channel;
  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      print(data);
      setState(() {
        notificacionesTotal++;
      });
    });
  }

  //ws://172.22.136.211:8000/ws/wk/988fba52c0cd87124dbd105eacc6c819cde87ded/notificaciones
  void initAsync() async {
    user = await controller.getDataUser(widget.token);
    final notis = await controllerNotificaciones.getNotifications(widget.token);
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
    streamListener();
    initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return isInitialize
        ? SliverAppBar.large(
            elevation: 0.0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.home,
              ),
            ),
            actions: [
              Consumer<NotificationsProvider>(
                builder: (context, notifier, child) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationPage(
                                    token: widget.token,
                                    cantidad: notificacionesTotal,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.notifications,
                              size: 40,
                            ),
                          ),
                          if ((notificacionesTotal -
                                  notifier.notificacionesLeidas) >
                              0)
                            Positioned(
                              right: 5,
                              top: 5,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Text(
                                  (notificacionesTotal -
                                          notifier.notificacionesLeidas)
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ));
                },
              )
            ],
            title: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Bienvenido de nuevo, ",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color.fromARGB(255, 220, 220, 220))),
                TextSpan(
                    text: user.nombres,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color.fromARGB(255, 226, 226, 226)))
              ]),
            ),
            pinned: false,
          )
        : SliverAppBar();
  }
}
