import 'package:flutter/material.dart';

class TileCustom extends StatelessWidget {
  final IconData icon;
  final String title;
  final double? titleSize;
  final Function()? onTap;
  final Widget? widgetAdj;
  const TileCustom(
      {super.key,
      required this.icon,
      required this.title,
      this.widgetAdj,
      this.onTap,
      this.titleSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    title,
                  )),
                  widgetAdj ??
                      Icon(
                        Icons.navigate_next_sharp,
                        size: 35,
                      )
                ],
              ))),
    );
  }
}
