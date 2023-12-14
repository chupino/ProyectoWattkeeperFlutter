import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/models/GroupMedicion.dart';
import 'package:wattkeeperr/models/medicion.dart';

class HistorialConsumoGrupo extends StatelessWidget {
  final List<GroupMedicion> mediciones;
  final List<Device> devices;
  const HistorialConsumoGrupo(
      {super.key, required this.mediciones, required this.devices});

  @override
  Widget build(BuildContext context) {
    List<Widget> historial;

    if (mediciones.isNotEmpty &&
        mediciones.every((e) => e.mediciones.isEmpty)) {
      historial = [Text('No hay mediciones por el momento')];
    } else if (mediciones.isNotEmpty) {
      historial = mediciones
          .expand((e) => [
                buildTile(e, context),
                SizedBox(
                  height: 10,
                ),
              ])
          .toList();
    } else {
      historial = [Text('No hay mediciones por el momento')];
    }
    return Column(
      children: historial,
    );
  }

  Widget buildTileIndividual(Medicion medicion, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.energy_savings_leaf,
                    color: Colors.amber,
                    size: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'C. Watts',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text("${(medicion.watts).toStringAsFixed(3)}W",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.electrical_services_outlined,
                    size: 40,
                    color: Colors.orange,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'C. Amperaje',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text("${(medicion.amperaje).toStringAsFixed(3)}A",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.electric_bolt_rounded,
                    size: 40,
                    color: Colors.redAccent,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'C. Voltaje',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text("${(medicion.voltaje).toStringAsFixed(3)}V",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [Text("Fecha: "), Text(medicion.getFormatedDate())],
          )
        ],
      ),
    );
  }

  Widget buildTile(GroupMedicion medicion, BuildContext context) {
    var device = devices.firstWhere((e) => e.id == medicion.device.id);
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  device.getTamagochiDynamicImage(),
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(medicion.device.nombre),
              ],
            ),
            children: medicion.mediciones
                .expand((e) => [
                      buildTileIndividual(e, context),
                      SizedBox(
                        height: 10,
                      )
                    ])
                .toList()),
      ),
    );
  }
}
