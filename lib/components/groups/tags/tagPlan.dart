import 'package:flutter/material.dart';

class TagPlan extends StatelessWidget {
  final bool hasPlan;
  const TagPlan({super.key, required this.hasPlan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: hasPlan ? Colors.greenAccent : Colors.redAccent,
          borderRadius: BorderRadius.circular(10)),
      child: hasPlan
          ? Row(
              children: [
                Text(
                  "Ahorro",
                ),
                Icon(Icons.security)
              ],
            )
          : Row(
              children: [Text("Ahorro"), Icon(Icons.gpp_bad_sharp)],
            ),
    );
  }
}
