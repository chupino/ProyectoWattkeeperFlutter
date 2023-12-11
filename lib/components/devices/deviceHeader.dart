import 'package:flutter/material.dart';
import 'package:wattkeeperr/pages/linkDevice.dart';

class DeviceHeader extends StatelessWidget {
  final String token;
  const DeviceHeader({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.devices_other,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LinkDevicePage(token: token)));
              },
              icon: Icon(Icons.add)),
        )
      ],
      title: Text("Dispositivos",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: const Color.fromARGB(255, 220, 220, 220),
              letterSpacing: 1,
              fontWeight: FontWeight.bold)),
      pinned: false,
    );
  }
}
