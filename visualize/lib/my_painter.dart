import 'package:flutter/material.dart';
import 'package:visualize/atom_model.dart';

class MyPainter extends CustomPainter {
  List<AtomWidget> elements;
  final int maxNeutronCount;
  final bool showArrows;

  MyPainter(
      {required this.showArrows,
      required this.elements,
      required this.maxNeutronCount});

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
    if (showArrows) {
      drawAllArrows(canvas, size);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.maxNeutronCount != maxNeutronCount ||
        oldDelegate.showArrows != showArrows;
  }

  void drawAllArrows(Canvas canvas, Size size) {
    int arrowTipWidth = 50;

    // fusion arrow
    Offset start = Offset(156, size.height - 56);
    Offset stop = Offset(436, size.height - (56 + 260));
    Color color = Colors.red;
    drawArrow(canvas, size, color, start, stop);
    drawArrowTop(canvas, color, stop, 30, arrowTipWidth);

    // rp Arrow
    start = Offset(156 + 200, size.height - (56 + 210));
    stop = Offset(156 + 500, size.height - (56 + 490));
    color = const Color.fromARGB(255, 9, 48, 202);
    drawArrow(canvas, size, color, start, stop);
    drawArrowTop(canvas, color, stop, 30, arrowTipWidth);

    // p arrow
    start = Offset(156 + 600, size.height - (56 + 500));
    stop = Offset(156 + 1000, size.height - (56 + 780));
    color = const Color.fromARGB(255, 171, 23, 163);
    drawArrow(canvas, size, color, start, stop);
    drawArrowTop(canvas, color, start, -30, -arrowTipWidth);

    // s arrow
    start = Offset(156 + 500, size.height - (56 + 400));
    stop = Offset(156 + 1100, size.height - (56 + 750));
    color = const Color.fromARGB(255, 251, 142, 9);
    drawArrow(canvas, size, color, start, stop);
    drawArrowTop(canvas, color, stop, 30, arrowTipWidth);

    // r arrow
    color = const Color.fromARGB(255, 134, 34, 205);
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    start = Offset(156 + 400, size.height - (56 + 250));
    stop = Offset(156 + 820, size.height - (56 + 400));
    drawArrow(canvas, size, color, start, stop);
    start = stop;
    stop = Offset(156 + 820, size.height - (56 + 420));
    canvas.drawLine(start, stop, paint);

    start = stop;
    stop = Offset(156 + 1260, size.height - (56 + 700));
    drawArrow(canvas, size, color, start, stop);
    start = stop;
    stop = Offset(156 + 1260, size.height - (56 + 724));
    canvas.drawLine(start, stop, paint);

    start = stop;
    stop = Offset(156 + 1620, size.height - (56 + 820));
    drawArrow(canvas, size, color, start, stop);
    drawArrowTop(canvas, color, stop, 50, 40);
  }

  void drawArrow(
      Canvas canvas, Size size, Color color, Offset start, Offset stop) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, stop, paint);
  }

  void drawArrowTop(
      Canvas canvas, Color color, Offset p, int width, int height) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    Offset stop = Offset(p.dx - width, p.dy + height);
    canvas.drawLine(p, stop, paint);
    stop = Offset(p.dx - 2 * width, p.dy + height / 4);
    canvas.drawLine(p, stop, paint);
  }
}
