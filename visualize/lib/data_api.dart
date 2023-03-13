import 'dart:convert';

import 'package:file_picker/file_picker.dart';
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
  //Pick file
  FilePickerResult csvFile = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'], type: FileType.custom, allowMultiple: false);

  //decode bytes back to utf8
  final bytes = utf8.decode(csvFile.files[0].bytes); //from the csv plugin
  List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter(fieldDelimiter: ",", eol: "\n").convert(bytes);

  List<AtomWidget> elements = <AtomWidget>[];
  rowsAsListOfValues.removeAt(0);
  for (List row in rowsAsListOfValues) {
    //print("Proton: ${row[0]}, Neutron: ${row[1]}, Symbol: ${row[2]}");
    try {
      bool stable = row[12].runtimeType == String && row[12] == "STABLE";
      Color color = Colors.white;
      String decay = row[18];

      switch (decay) {
        case "N":
          color = Colors.pink;
          break;

        case "B-":
          color = Colors.blue;
          break;
        case "SF":
          color = const Color.fromARGB(255, 183, 100, 67);
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
        case "P":
          color = Colors.orange;
          break;

        default:
          color = Colors.white;
      }
      if (stable) color = Colors.black;

      elements.add(AtomWidget(
        protonCount: row[0],
        neutronCount: row[1],
        symbol: row[2],
        decay: row[18],
        color: color,
      ));
    } catch (e) {
      print(e);
    }
  }
  return elements;
}
