import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:visualize/atom_model.dart';
import 'package:visualize/data_api.dart';
import 'package:visualize/graph_background.dart';

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

  @override
  void initState() {
    super.initState();
  }

  List<Widget> screen = [];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    screen.insertAll(0,
        [const GraphBackgroundWidget(), customSlider(), loadElementsButton()]);

    return Scaffold(
        body: Stack(
      children: screen,
    ));
  }

  Widget loadElementsButton() {
    return ElevatedButton(
        onPressed: () async {
          atoms = await importCSV();

          setState(() {
            screen.insertAll(0, atoms.sublist(0, _sliderValue.toInt()));
          });
        },
        child: const Text("Load Data"));
  }

  Widget customSlider() {
    return Positioned(
      top: 32,
      left: screenWidth / 4,
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

              screen = [
                const GraphBackgroundWidget(),
                customSlider(),
                loadElementsButton()
              ];

              screen.insertAll(
                  0,
                  atoms.where((element) =>
                      element.neutronCount <= _sliderValue.toInt()));
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
