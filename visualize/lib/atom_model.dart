import 'package:flutter/material.dart';

class AtomWidget extends StatelessWidget {
  final int protonCount;
  final int neutronCount;
  final String symbol;
  final dynamic decay;

  final Color color;

  const AtomWidget(
      {super.key,
      required this.protonCount,
      required this.neutronCount,
      required this.symbol,
      required this.decay,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 150 + neutronCount * 10,
        bottom: 50 + protonCount * 10,
        child: GestureDetector(
          onTap: () {
            print(symbol + protonCount.toString() + neutronCount.toString());
          },
          child: Container(
            width: 10,
            height: 10,
            color: color,
          ),
        ));
  }
}
