import 'package:flutter/material.dart';
import 'package:visualize/atom_model.dart';

class MyPainter extends CustomPainter {
  List<AtomWidget> elements;
  final int maxNeutronCount;

  MyPainter({required this.elements, required this.maxNeutronCount});

  final Size s = const Size(10, 10);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    for (AtomWidget a in elements
        .where((element) => element.neutronCount <= maxNeutronCount)) {
      paint.color = a.color;
      Offset position = Offset(a.x, size.height - a.y);
      canvas.drawRect(position & s, paint);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.maxNeutronCount != maxNeutronCount;
  }
}
