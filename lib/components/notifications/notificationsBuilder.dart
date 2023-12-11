
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/notifications/NotificationCard.dart';
import 'package:wattkeeperr/models/Notification.dart';



class NotificationsBuilder extends StatelessWidget {
  final String token;
  final List<NotificationModel> notificaciones;
  const NotificationsBuilder(
      {super.key, required this.token, required this.notificaciones});

  @override
  Widget build(BuildContext context) {
    notificaciones.sort((a, b) => b.fechaEnvio.compareTo(a.fechaEnvio));
    return Column(
      children: notificaciones
          .map((e) => NotificationCard(
                notification: e,
                token: token,
              ))
          .toList(),
    );
  }
}
