import 'package:flutter/material.dart';
import 'SampleItemViewModel.dart';

class SampleItemUpdate extends StatefulWidget {
  final String? initialName;
  final String? initialGroupName;
  final String? initialMemberName;

  const SampleItemUpdate({
    Key? key,
    this.initialName,
    this.initialGroupName,
    this.initialMemberName,
  }) : super(key: key);

  @override
  _SampleItemUpdateState createState() => _SampleItemUpdateState();
}

class _SampleItemUpdateState extends State<SampleItemUpdate> {
  late TextEditingController groupTextEditingController;
  late TextEditingController memberTextEditingController;

  @override
  void initState() {
    super.initState();

    groupTextEditingController =
        TextEditingController(text: widget.initialGroupName);
    memberTextEditingController =
        TextEditingController(text: widget.initialMemberName);
  }

  @override
  void dispose() {
    groupTextEditingController.dispose();
    memberTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialName != null ? 'Chỉnh sửa' : 'Thêm mới'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop({
                'groupName': groupTextEditingController.text,
                'memberName': memberTextEditingController.text,
              });
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: groupTextEditingController,
            decoration: InputDecoration(labelText: 'Tên nhóm'),
          ),
          TextFormField(
            controller: memberTextEditingController,
            decoration: InputDecoration(labelText: 'Tên thành viên'),
          ),
        ],
      ),
    );
  }
}
