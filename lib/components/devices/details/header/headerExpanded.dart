import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/DeviceDetails.dart';

class DeviceDetailsExpandedHeader extends StatelessWidget {
  final DeviceDetails device;
  double shrinkOffset;
  DeviceDetailsExpandedHeader(
      {super.key, required this.device, required this.shrinkOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1C2434),
      child: Transform.scale(
        scale: 1.0 - (shrinkOffset / 200),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SingleChildScrollView(
              // Agregado
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    device.nombre,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.white),
                  ),
                  Flexible(
                      child: Image.network(device.getTamagochiDynamicImage(),
                          height: 100))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
