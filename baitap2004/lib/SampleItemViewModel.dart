import 'package:flutter/material.dart';
import 'SampleItem.dart';

class SampleItemViewModel extends ChangeNotifier {
  static final _instance = SampleItemViewModel._();
  factory SampleItemViewModel() => _instance;
  SampleItemViewModel._();
  final List<SampleItem> items = [];

  void addItem({
    required String groupName,
    required String memberName,
  }) {
    items.add(SampleItem(groupName: groupName, memberName: memberName));
    notifyListeners();
  }

  void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateItem(String id, String newGroupName, String newMemberName) {
    try {
      final item = items.firstWhere((item) => item.id == id);
      item.groupName = newGroupName;
      item.memberName = newMemberName;
    } catch (e) {
      debugPrint("Không tìm thấy mục với ID $id");
    }
    notifyListeners();
  }
}
