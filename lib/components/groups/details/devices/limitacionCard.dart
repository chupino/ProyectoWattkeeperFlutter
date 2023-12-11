import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/groups/details/devices/limitacionSwitch.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';

class LimitacionPlanAhorroCard extends StatefulWidget {
  bool enabled;
  final GroupDetails groupDetails;
  LimitacionPlanAhorroCard(
      {super.key, required this.enabled, required this.groupDetails});

  @override
  State<LimitacionPlanAhorroCard> createState() =>
      _LimitacionPlanAhorroCardState();
}

enum TipoMedicion { dias, semanas, meses }

class _LimitacionPlanAhorroCardState extends State<LimitacionPlanAhorroCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          LimitationSwitch(
              onToggle: (value) {}, enabled: widget.groupDetails.ahorroEnabled),
          widget.groupDetails.ahorroEnabled
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Limite Consumo',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoSlider(
                            value: widget.groupDetails.limiteConsumo!,
                            min: 0,
                            max: 513715,
                            onChanged: (value) {}),
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).cardColor),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            child: Text(
                              "${(widget.groupDetails.limiteConsumo! / 1000).toInt()}kW",
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tiempo Medición',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ), //subir bajar
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).cardColor),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 28),
                          child: Text(
                            tiempoMedicion.toString(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tipo Medición',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).cardColor),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Text(
                            tipoMedicionString.toString(),
                          ),
                        ),
                      ],
                    ) */
                  ],
                )
              : Column(
                  children: [
                    Lottie.asset('assets/animations/workingit.json'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Parece que el grupo "${widget.groupDetails.nombre}" no tiene habilitado un plan de ahorro'),
                  ],
                )
        ],
      ),
    );
  }
}
