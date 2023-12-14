import 'package:flutter/material.dart';

class GeneralInfoDeviceDetails extends StatelessWidget {
  final String ultimaMedicion;
  final String tiempoTranscurrido;
  final double acumuladoWatts;
  final double amperaje;
  final double voltaje;
  const GeneralInfoDeviceDetails(
      {super.key,
      required this.ultimaMedicion,
      required this.tiempoTranscurrido,
      required this.acumuladoWatts,
      required this.amperaje,
      required this.voltaje});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ultima Medición',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  ultimaMedicion,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(" · "),
                Text(
                  tiempoTranscurrido,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Consumo Total'),
            Text(
              "${(acumuladoWatts / 1000).toStringAsFixed(3)}kW",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.amberAccent),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Último Voltaje'),
            Text(
              "${(voltaje).toStringAsFixed(3)}V",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.amberAccent),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Último Amperaje'),
            Text(
              "${(amperaje).toStringAsFixed(3)}A",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.amberAccent),
            )
          ],
        ));
  }
}
