import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/deviceCardNoEdit.dart';
import 'package:wattkeeperr/components/devices/nonDevices.dart';
import 'package:wattkeeperr/components/groups/details/devices/NonDevicesNoAction.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';

class DevicesGroupScheme extends StatelessWidget {
  final GroupDetails groupDetails;
  final String token;
  final Future Function() onRefresh;
  const DevicesGroupScheme(
      {super.key, required this.groupDetails, required this.token, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    List<Widget> dispositivos = groupDetails.dispositivos
        .map((e) => DeviceCardNoEdit(token: token, device: e))
        .toList();
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          Text(
            'Dispositivos',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 10,
          ),
          dispositivos.isNotEmpty
              ? GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0),
                  itemCount: dispositivos.length,
                  itemBuilder: (context, index) {
                    return dispositivos[index];
                  })
              : NonDevicesNoAction(
                  message:
                      'El grupo ${groupDetails.nombre} no tiene dispositivos')
        ],
      ),
    );
  }
}
