
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/buttons/customButton.dart';

class NonGroups extends StatelessWidget {
  const NonGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Lottie.asset('assets/animations/void.json', height: 200),
              const SizedBox(
                width: 10,
              ),
              const Flexible(
                child: Text(
                  'Parece que no tienes ningun grupo',
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                    text: 'Unirme a uno',
                    onPressed: () {
                      
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
