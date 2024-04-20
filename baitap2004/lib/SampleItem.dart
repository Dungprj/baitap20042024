import 'dart:math';
import 'package:flutter/material.dart';

class SampleItem {
  String id;
  ValueNotifier<String> name;

  SampleItem({String? id, required String name})
      : id = id ?? generateUuid(),
        name = ValueNotifier(name);

  static String generateUuid() {
    return int.parse(
      '${DateTime.now().millisecondsSinceEpoch}${Random().nextInt(10000)}',
    ).toRadixString(35).substring(0, 8);
  }
}
