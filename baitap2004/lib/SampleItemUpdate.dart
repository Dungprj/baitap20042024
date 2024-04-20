import 'package:flutter/material.dart';
import 'SampleItemViewModel.dart';

class SampleItemUpdate extends StatefulWidget {
  final String? initialName;

  const SampleItemUpdate({Key? key, this.initialName}) : super(key: key);

  @override
  _SampleItemUpdateState createState() => _SampleItemUpdateState();
}

class _SampleItemUpdateState extends State<SampleItemUpdate> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    textEditingController.dispose();
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
              Navigator.of(context).pop(textEditingController.text);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: TextFormField(
        controller: textEditingController,
      ),
    );
  }
}
