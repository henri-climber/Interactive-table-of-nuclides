import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:visualize/atom_model.dart';
import 'package:visualize/data_api.dart';
import 'package:visualize/graph_background.dart';
import 'package:visualize/my_painter.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  late double screenHeight;
  late double screenWidth;

  double _sliderValue = 20;
  List<AtomWidget> atoms = [];
  List<AtomWidget> allAtoms = [];

  double x = 0.0;
  double y = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: MouseRegion(
            onHover: _updateLocation,
            child: Stack(
              children: [
                const GraphBackgroundWidget(),
                CustomPaint(
                  painter: MyPainter(
                      elements: atoms, maxNeutronCount: _sliderValue.toInt()),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(150, 0, 0, 50),
                      child: Container()),
                ),
                customSlider(),
                loadElementsButton(),
                showDetialsOfElement()
              ],
            )));
  }

  Widget showDetialsOfElement() {
    if (allAtoms.isNotEmpty) {
      int neutronCount = (x - 150) ~/ 10;
      int protonCount = (screenHeight - y - 50) ~/ 10;

      try {
        AtomWidget a = allAtoms
            .where((element) {
              return element.neutronCount == neutronCount &&
                  element.protonCount == protonCount;
            })
            .toList()
            .elementAt(0);

        return Positioned(
            right: 100,
            bottom: 150,
            child: Text(
              "Symbol: ${a.symbol}\nProtonen Anzahl: ${a.protonCount}\nNeutronen Anzahl: ${a.neutronCount}\nZerfall: ${a.decay}",
              style: Theme.of(context).textTheme.headlineMedium,
            ));
      } catch (e) {
        // no element with these proton and neutron count
      }
    }

    return const Positioned(right: 16, bottom: 100, child: Text(""));
  }

// fetches mouse pointer location
  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  Widget loadElementsButton() {
    return ElevatedButton(
        onPressed: () async {
          //await getNeuklidData();
          allAtoms = await importCSV();

          setState(() {
            atoms = allAtoms;
          });
        },
        child: const Text(
          "Load Data",
          style: TextStyle(fontSize: 13),
        ));
  }

  Widget customSlider() {
    return Positioned(
      top: 32,
      left: 200,
      child: Column(children: [
        Slider(
          inactiveColor: Colors.grey,
          thumbColor: Colors.black,
          activeColor: const Color.fromARGB(255, 120, 49, 168),
          value: _sliderValue,
          max: 200,
          divisions: null,
          label: _sliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
        Text(
          "Neutronenzahl: ${_sliderValue.toInt()}",
          style: Theme.of(context).textTheme.labelMedium,
        )
      ]),
    );
  }
}
