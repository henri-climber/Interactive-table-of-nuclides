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
  final Future<List<AtomWidget>> _loadAtoms = importCSV();

  double x = 0.0;
  double y = 0.0;
  bool showArrows = false;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: MouseRegion(
            onHover: _updateLocation,
            child: FutureBuilder(
              future: _loadAtoms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  allAtoms = snapshot.data as List<AtomWidget>;
                  atoms = allAtoms;
                  return Stack(
                    children: [
                      const GraphBackgroundWidget(),
                      CustomPaint(
                        painter: MyPainter(
                          showArrows: showArrows,
                          elements: atoms,
                          maxNeutronCount: _sliderValue.toInt(),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(150, 0, 0, 50),
                            child: Container()),
                      ),
                      customSlider(),
                      toggleShowArrows(),
                      showDetialsOfElement(),
                      if (showArrows)
                        displayArrowLegend(230, 90, "Fusion bis Eisen"),
                      if (showArrows)
                        displayArrowLegend(530, 390, "RP-Prozess"),
                      if (showArrows) displayArrowLegend(820, 690, "P-Prozess"),
                      if (showArrows) displayArrowLegend(960, 590, "S-Prozess"),
                      if (showArrows) displayArrowLegend(1350, 670, "R-Prozess")
                    ],
                  );
                }

                return const GraphBackgroundWidget();
              },
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

  Widget toggleShowArrows() {
    return Positioned(
      top: 32,
      left: 400,
      child: Row(children: [
        const Text(
          "Zeige Prozessbereiche: ",
          style: TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: showArrows
              ? const Icon(Icons.check_box)
              : const Icon(Icons.check_box_outline_blank),
          onPressed: () {
            setState(() {
              showArrows = showArrows ? showArrows = false : showArrows = true;
            });
          },
        )
      ]),
    );
  }

  Widget displayArrowLegend(double x, double y, String text) {
    return Positioned(
        left: x,
        bottom: y,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
