import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/settings/switchCustom.dart';

class LimitationSwitch extends StatelessWidget {
  final Function(bool value) onToggle;
  final bool enabled;
  const LimitationSwitch(
      {super.key, required this.onToggle, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Activado",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SwitchCustom(
            activeColor: Colors.blueAccent, value: enabled, onToggle: onToggle)
      ],
    );
  }
}
