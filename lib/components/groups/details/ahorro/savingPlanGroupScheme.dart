import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/groups/details/devices/limitacionCard.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';

class SavingPlanScheme extends StatelessWidget {
  final GroupDetails groupDetails;
  final Future Function() onRefresh;
  const SavingPlanScheme({super.key, required this.groupDetails, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          Text(
            'Plan de Ahorro',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 10,
          ),
          LimitacionPlanAhorroCard(
              enabled: groupDetails.ahorroEnabled, groupDetails: groupDetails),
        ],
      ),
    );
  }
}
