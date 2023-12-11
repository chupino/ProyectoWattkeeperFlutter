import 'package:flutter/material.dart';
import 'package:wattkeeperr/pages/linkDevice.dart';

class LinkDeviceSection extends StatelessWidget {
  final String token;
  const LinkDeviceSection({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LinkDevicePage(token: token)));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(
              Icons.add_link,
              size: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                "Vincular Nuevo Dispositivo",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
