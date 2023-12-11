import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/medicion.dart';

class HistorialScheme extends StatelessWidget {
  final List<Medicion> mediciones;
  const HistorialScheme({super.key, required this.mediciones});

  @override
  Widget build(BuildContext context) {
    mediciones.sort((a, b) => b.fechaMedicion!.compareTo(a.fechaMedicion!));
    List<Widget> historial = mediciones.isNotEmpty
        ? mediciones
            .expand((e) => [
                  buildTile(e, context),
                  SizedBox(
                    height: 10,
                  ),
                ])
            .toList()
        : [Text('No hay mediciones por el momento')];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [...historial],
        ),
      ),
    );
  }

  Widget buildTile(Medicion medicion, BuildContext context) {
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
                    children: [
                      Text(
                        'C. Watts',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text("${medicion.watts}W",
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
                    children: [
                      Text(
                        'C. Amperaje',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text("${medicion.amperaje}W",
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
                    children: [
                      Text(
                        'C. Voltaje',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text("${medicion.voltaje}W",
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
}
