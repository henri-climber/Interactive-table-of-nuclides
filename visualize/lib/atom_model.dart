import 'package:flutter/material.dart';

class AtomWidget {
  final int protonCount;
  final int neutronCount;
  final String symbol;
  final dynamic decay;
  final Color color;
  late double x;
  late double y;

  AtomWidget(
      {required this.protonCount,
      required this.neutronCount,
      required this.symbol,
      required this.decay,
      required this.color}) {
    x = 150 + neutronCount * 10;
    y = 60 + protonCount * 10;
  }
}
