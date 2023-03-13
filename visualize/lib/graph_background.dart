import 'package:flutter/material.dart';

class GraphBackgroundWidget extends StatefulWidget {
  const GraphBackgroundWidget({super.key});

  @override
  State<GraphBackgroundWidget> createState() => _GraphBackgroundWidgetState();
}

class _GraphBackgroundWidgetState extends State<GraphBackgroundWidget> {
  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        xAxis(),
        yAxis(),
        Positioned(
          bottom: 12,
          left: screenWidth / 2 - 100,
          child: Text(
            "Neutronenzahl",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Positioned(
            left: 10,
            top: screenHeight / 2,
            child: Center(
              child: Text("Protonenzahl",
                  style: Theme.of(context).textTheme.headlineSmall),
            )),

        // X - Arrow
        Positioned(
            left: screenWidth - 90,
            bottom: 21,
            child: const Icon(
              Icons.arrow_forward,
              size: 64,
              color: Colors.black,
            )),

        // Y - Arrow
        const Positioned(
            top: 28,
            left: 121,
            child: Icon(Icons.arrow_upward, size: 64, color: Colors.black)),
      ],
    );
  }

  Widget xAxis() {
    return Positioned(
        left: 150,
        bottom: 50,
        child: Container(
          width: screenWidth - 200,
          height: 6,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ));
  }

  Widget yAxis() {
    return Positioned(
        left: 150,
        bottom: 50,
        child: Container(
          width: 6,
          height: screenHeight - 100,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ));
  }
}
