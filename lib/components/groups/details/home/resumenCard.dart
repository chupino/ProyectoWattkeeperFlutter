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
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              childrenPadding: EdgeInsets.only(left: 20),
              title: Row(
                children: [
                  const Icon(
                    Icons.admin_panel_settings,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Creador del Grupo",
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
              children: [
                Text(
                    "${groupDetails.creador.nombres} ${groupDetails.creador.apellidos}",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.normal)),
                Text(
                  groupDetails.creador.email,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
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
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        childrenPadding: EdgeInsets.only(left: 20),
                        title: Row(
                          children: [
                            const Icon(
                              Icons.health_and_safety,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Plan de Ahorro",
                              style: Theme.of(context).textTheme.labelLarge,
                            )
                          ],
                        ),
                        children: [
                          Text(
                            "Este grupo tiene habilidado un plan de ahorro, lo cual significa que se estara supervisando su consumo",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        childrenPadding: EdgeInsets.only(left: 20),
                        title: Row(
                          children: [
                            const Icon(
                              Icons.health_and_safety,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Plan de Ahorro",
                              style: Theme.of(context).textTheme.labelLarge,
                            )
                          ],
                        ),
                        children: [
                          Text(
                            "Este grupo no tiene habilidado un plan de ahorro",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          expandedAlignment: Alignment.centerLeft,
                          childrenPadding: EdgeInsets.only(left: 20),
                          title: Row(
                            children: [
                              const Icon(
                                Icons.card_giftcard,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Recompensas",
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            ],
                          ),
                          children: [
                            Text(
                              "Este grupo tiene habilitadas las recompensas, ahorre para conseguirlas todas!",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontWeight: FontWeight.normal),
                            )
                          ]),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        childrenPadding: EdgeInsets.only(left: 20),
                        title: Row(
                          children: [
                            const Icon(
                              Icons.card_giftcard,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Recompensas desactivadas",
                              style: Theme.of(context).textTheme.labelLarge,
                            )
                          ],
                        ),
                        children: [
                          Text(
                            "Este grupo no tiene habilitado las recompensas",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
