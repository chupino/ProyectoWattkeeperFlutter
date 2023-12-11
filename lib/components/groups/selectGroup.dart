import 'package:flutter/material.dart';

class SelectGroup extends StatefulWidget {
  String selected;
  Function(String value) changeGroup;
  SelectGroup({required this.selected, required this.changeGroup, super.key});

  @override
  State<SelectGroup> createState() => _SelectGroupState();
}

class _SelectGroupState extends State<SelectGroup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Ver:',
                  ),
                  RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      tileColor: Colors.transparent,
                      title: const Text(
                        "Mis Grupos",
                      ),
                      value: "Mis Grupos",
                      groupValue: widget.selected,
                      onChanged: (value) {
                        setState(() {
                          widget.selected = value!;
                          widget.changeGroup(value);
                        });
                        Navigator.pop(context);
                      }),
                  RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      tileColor: Colors.transparent,
                      title: const Text(
                        "Grupos Afiliados",
                      ),
                      value: "Grupos Afiliados",
                      groupValue: widget.selected,
                      onChanged: (value) {
                        setState(() {
                          widget.selected = value!;
                          widget.changeGroup(value);
                        });
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          },
        );
      },
      child: Row(children: [
        Text(
          widget.selected,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.arrow_drop_down,
          size: 40,
        )
      ]),
    );
  }
}
