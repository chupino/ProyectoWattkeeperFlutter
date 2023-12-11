import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/notifications/notificationsScheme.dart';

class NotificationPage extends StatelessWidget {
  final String token;
  final int cantidad;
  const NotificationPage({super.key, required this.token, required this.cantidad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NotificationsScheme(
          token: token,
          cantidad: cantidad,
        ),
      ),
    );
  }
}
