import 'package:flutter/material.dart';

class ConsumoGrupoCard extends StatelessWidget {
  final double amperaje;
  final double voltaje;
  final double wattsAcumulado;
  final String fecha;
  const ConsumoGrupoCard(
      {super.key,
      required this.amperaje,
      required this.voltaje,
      required this.wattsAcumulado,
      required this.fecha});

  String formattedDate(String dateTimeString) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime == null) {
      return '';
    }

    final formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  String calculateTimeDifference(String dateTimeString) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString);

    if (dateTime == null) {
      return 'Fecha inválida';
    }

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return "Hace ${difference.inSeconds} segundos";
    } else if (difference.inMinutes < 60) {
      return "Hace ${difference.inMinutes} minutos";
    } else if (difference.inHours < 24) {
      return "Hace ${difference.inHours} horas";
    } else {
      return "Hace ${difference.inDays} días";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor),
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
                formattedDate(fecha),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(" · "),
              Text(
                calculateTimeDifference(fecha),
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
          Text('Consumo Periodico Total'),
          Text(
            "${wattsAcumulado / 1000}kW",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.amberAccent),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Ultimo Voltaje'),
          Text(
            "${voltaje}V",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.amberAccent),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Ultimo Amperaje'),
          Text(
            "${amperaje}A",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.amberAccent),
          )
        ],
      ),
    );
  }
}
