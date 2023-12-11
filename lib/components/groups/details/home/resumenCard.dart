import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';

class ResumenCard extends StatelessWidget {
  final GroupDetails groupDetails;
  const ResumenCard({super.key, required this.groupDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.admin_panel_settings,
                size: 40,
              ),
              Text("Creador del Grupo:",
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Text(
              "${groupDetails.creador.nombres} ${groupDetails.creador.apellidos}",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.normal)),
          Text(
            groupDetails.creador.email,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          groupDetails.ahorroEnabled
              ? Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.health_and_safety,
                          color: Colors.green,
                        ),
                        Text(
                          "Plan de Ahorro Habilitado",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    Text(
                      "Este grupo tiene habilidado un plan de ahorro, lo cual significa que se estara supervisando su consumo",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    )
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.health_and_safety,
                          color: Colors.red,
                        ),
                        Text(
                          "Plan de Ahorro Deshabilitado",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    Text(
                      "Este grupo no tiene habilidado un plan de ahorro",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          groupDetails.recompensas.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard,
                          color: Colors.green,
                        ),
                        Text(
                          "Recompensas",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    Text(
                      "Este grupo tiene habilidadas las recompensas, ahorre para conseguirlas todas!",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    )
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard,
                          color: Colors.red,
                        ),
                        Text(
                          "Recompensas desactivadas",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    Text(
                      "Este grupo no tiene habilitado las recompensas",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
