import 'package:flutter/material.dart';

class DeviceScanned extends StatelessWidget {
  final String direccionMac;
  const DeviceScanned({super.key, required this.direccionMac});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.device_unknown,
            size: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dispositivo Wattkeeper',
              ),
              Text(
                direccionMac,
              ),
            ],
          )
        ],
      ),
    );
  }
}
