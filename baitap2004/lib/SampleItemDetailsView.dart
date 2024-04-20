import 'package:baitap2004/SampleItem.dart';
import 'package:baitap2004/SampleItemUpdate.dart';
import 'package:baitap2004/SampleItemViewModel.dart';
import 'package:flutter/material.dart';

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
              showModalBottomSheet<String?>(
                context: context,
                builder: (context) => SampleItemUpdate(
                  initialName: widget.item.name.value,
                ),
              ).then((value) {
                if (value != null) {
                  viewModel.updateItem(widget.item.id, value);
                }
              });
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Xác nhận xóa"),
                    content: const Text("Bạn có chắc muốn xóa mục này"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Đóng dialog mà không xóa
                        },
                        child: const Text("Hủy"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Đóng dialog và tiếp tục xóa
                          viewModel.removeItem(widget.item.id); // Xóa item
                          Navigator.of(context).pop(
                              true); // Quay lại màn hình trước đó (nếu cần)
                        },
                        child: const Text("Xóa"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: widget.item.name,
        builder: (_, name, __) {
          return Center(child: Text(name));
        },
      ),
    );
  }
}
