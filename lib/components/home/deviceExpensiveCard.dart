import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/models/DeviceExpensive.dart';
import 'package:wattkeeperr/pages/deviceDetailsPage.dart';

class DeviceExpensiveCard extends StatelessWidget {
  final List<Device> devices;
  final String token;
  final DeviceExpensive deviceExpensive;
  const DeviceExpensiveCard(
      {super.key,
      required this.deviceExpensive,
      required this.devices,
      required this.token});

  @override
  Widget build(BuildContext context) {
    var device = devices.firstWhere((e) => e.nombre == deviceExpensive.nombre);
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor),
      child: Row(
        children: [
          Image.network(
            device.getTamagochiDynamicImage(),
            height: 80,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deviceExpensive.nombre,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 35),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DeviceDetailsPage(device: device, token: token)));
                },
                child: Text('Ver Dispositivo'),
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10))),
              )
            ],
          ),
        ],
      ),
    );
  }
}
