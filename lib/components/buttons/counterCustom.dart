import 'package:flutter/material.dart';

class CounterCustom extends StatelessWidget {
  int counter;
  final Function() incrementar;
  final Function() decrecer;
  CounterCustom(
      {required this.counter,
      super.key,
      required this.incrementar,
      required this.decrecer});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: incrementar,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 35,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: const Icon(Icons.add),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 35,
          width: 30,
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.all(5),
          child: Text(
            counter.toString(),
          ),
        ),
        GestureDetector(
          onTap: decrecer,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 35,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}
