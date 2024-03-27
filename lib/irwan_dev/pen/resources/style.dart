import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Map<String, int> sortBasedOnValueNew(Map<String, int> input) {
  Map<String, int> output = {};
  List<String> sortedKeys = input.keys.toList()
    ..sort((a, b) {
      try {
        return input[b].compareTo(input[a]);
      } catch (ex) {
        return 0;
      }
    });
  sortedKeys.forEach((key) => output[key] = input[key]);
  return output;
}

//Decoration Blue Line
Decoration decor = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    color: Colors.blue,
    width: 1.5,
  ),
);

Decoration decorationMainContainer = BoxDecoration(
  borderRadius: BorderRadius.circular(6),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.6),
      blurRadius: 2,
      spreadRadius: 2,
      offset: Offset(0, 3),
    ),
  ],
);
