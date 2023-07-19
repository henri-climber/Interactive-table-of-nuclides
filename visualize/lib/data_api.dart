// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:periodic_table/periodic_table.dart';
import 'package:visualize/atom_model.dart';

import 'package:csv/csv.dart';

List<AtomWidget> getElements() {
  List<AtomWidget> elements = <AtomWidget>[];

  for (ChemicalElement cm in periodicTable) {
    int protonCount = cm.number;
    int neutronCount = (cm.atomicMass - cm.number).toInt();
    elements.add(AtomWidget(
      protonCount: protonCount,
      neutronCount: neutronCount,
      symbol: cm.name,
      decay: "d",
      color: Colors.black,
    ));
  }
  return elements;
}

Future<List<AtomWidget>> importCSV() async {
  final response = await html.HttpRequest.getString('assets/nuclid_data.csv');

  List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(
    fieldDelimiter: ",",
    eol: "\n",
  ).convert(response);

  List<AtomWidget> elements = <AtomWidget>[];
  rowsAsListOfValues.removeAt(0);

  var allDecays = [];

  for (List row in rowsAsListOfValues) {
    //print("Proton: ${row[0]}, Neutron: ${row[1]}, Symbol: ${row[2]}");
    try {
      bool stable = row[12].runtimeType == String && row[12] == "STABLE";
      Color color = Colors.white;
      String decay = row[18];

      switch (decay) {
        case "B-":
          color = Colors.blue;
          break;
        case "2B-":
          color = Colors.blue;
          break;
        case "IT":
          color = Colors.blue;
          break;
        case "2EC":
          color = Colors.green;
          break;
        case "B+":
          color = Colors.orange;
          break;
        case "2+":
          color = Colors.orange;
          break;

        case "N":
          color = Colors.pink;
          break;
        case "2N":
          color = Colors.pink;
          break;

        case " ":
          color = Colors.grey;
          break;
        case "P":
          color = Colors.orange;
          break;
        case "2P":
          color = Colors.orange;
          break;
        case "B+P":
          color = Colors.lightGreenAccent;
          break;
        case "B-N":
          color = Colors.lightGreenAccent;
          break;
        case "B-2N":
          color = Colors.lightGreenAccent;
          break;

        case "A":
          color = Colors.yellow;
          break;

        case "EC+B+":
          color = Colors.green;
          break;
        case "EC":
          color = Colors.green;
          break;

        case "SF":
          color = const Color.fromARGB(255, 183, 100, 67);
          break;

        default:
          color = Colors.white;
      }
      if (stable) {
        color = Colors.black;
        decay = "Stabil";
      }
      allDecays.add(decay);
      elements.add(AtomWidget(
        protonCount: row[0],
        neutronCount: row[1],
        symbol: row[2],
        decay: decay,
        color: color,
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  return elements;
}
