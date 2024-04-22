import 'package:flutter/material.dart';
import 'SampleItem.dart';
import 'SampleItemUpdate.dart';
import 'SampleItemViewModel.dart';

class SampleItemDetailsView extends StatefulWidget {
  final SampleItem item;

  const SampleItemDetailsView({Key? key, required this.item}) : super(key: key);

  @override
  _SampleItemDetailsViewState createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  final viewModel = SampleItemViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: [
          IconButton(
            onPressed: () {
              _editItem();
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _confirmDeleteItem();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Tên Nhóm: ${widget.item.groupName}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Tên Thành Viên: ${widget.item.memberName}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _editItem() async {
    final updatedValues = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(
        builder: (context) => SampleItemUpdate(
          initialName: widget.item.name.value,
          initialGroupName: widget.item.groupName,
          initialMemberName: widget.item.memberName,
        ),
      ),
    );
    if (updatedValues != null) {
      setState(() {
        widget.item.groupName =
            updatedValues['groupName'] ?? widget.item.groupName;
        widget.item.memberName =
            updatedValues['memberName'] ?? widget.item.memberName;
      });
    }
  }

  void _confirmDeleteItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận xóa"),
          content: const Text("Bạn có chắc muốn xóa mục này"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog mà không xóa
              },
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog và tiếp tục xóa
                viewModel.removeItem(widget.item.id); // Xóa item
                Navigator.of(context)
                    .pop(true); // Quay lại màn hình trước đó (nếu cần)
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }
}
