import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';
import 'package:wattkeeperr/models/Recompensa.dart';

class RecompensaCard extends StatelessWidget {
  final Recompensa recompensa;
  final String token;
  final int id;
  double consumoTotal;
  RecompensaCard(
      {super.key,
      required this.recompensa,
      required this.token,
      required this.id,
      required this.consumoTotal});

  @override
  Widget build(BuildContext context) {
    consumoTotal > recompensa.limiteWatts
        ? consumoTotal = recompensa.limiteWatts
        : consumoTotal;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Theme.of(context).cardColor,
              ),
              width: double.infinity,
              child: const Icon(
                Icons.redeem,
                size: 150,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(recompensa.recompensa),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Recompensa por consumir menos de ${recompensa.limiteWatts}W",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.amber),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text.rich(TextSpan(
                              text: consumoTotal.toString(),
                              style: Theme.of(context).textTheme.labelSmall,
                              children: [
                                TextSpan(text: "/"),
                                TextSpan(
                                  text: "${recompensa.limiteWatts}W",
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              ])),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LinearPercentIndicator(
                      lineHeight: 40,
                      percent: consumoTotal / recompensa.limiteWatts,
                      progressColor: (consumoTotal / recompensa.limiteWatts) > 0.75 ? Colors.red :  Theme.of(context).primaryColorDark,
                      barRadius: Radius.circular(20),
                    )
                  ]),
            )
          ],
        ),
        Positioned(
          left: 10,
          bottom: 150,
          child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: consumoTotal < recompensa.limiteWatts
                      ? Colors.green
                      : Colors.red),
              child: consumoTotal < recompensa.limiteWatts
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.clear,
                      color: Colors.white,
                    )),
        ),
      ],
    );
  }
}
