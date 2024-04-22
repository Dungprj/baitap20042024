import 'package:flutter/foundation.dart';

class SampleItem {
  static int _idCounter = 0;
  String id;
  String groupName;
  String memberName;
  ValueNotifier<String> name;

  SampleItem({
    required this.groupName,
    required this.memberName,
  })  : id = generateId(),
        name = ValueNotifier("ID : ${_idCounter}");

  static String generateId() {
    return 'ID_${++_idCounter}';
  }
}
