import 'package:flutter/material.dart';
import 'package:baitap2004/SampleItem.dart';
import 'package:baitap2004/SampleItemDetailsView.dart';
import 'package:baitap2004/SampleItemUpdate.dart';
import 'package:baitap2004/SampleItemViewModel.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({Key? key}) : super(key: key);

  @override
  _SampleItemListViewState createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  final viewModel = SampleItemViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Phân Nhóm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<Map<String, String>>(
                context: context,
                builder: (context) => const SampleItemUpdate(),
              ).then((value) {
                if (value != null) {
                  viewModel.addItem(
                    groupName: value['groupName'] ?? '',
                    memberName: value['memberName'] ?? '',
                  );
                }
              });
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: viewModel.items.length,
            itemBuilder: (context, index) {
              final item = viewModel.items[index];
              return ListTile(
                title: Text(item.name.value),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tên Nhóm: ${item.groupName}'),
                    Text('Tên Thành Viên: ${item.memberName}'),
                  ],
                ),
                onTap: () {
                  Navigator.of(context)
                      .push<bool>(
                    MaterialPageRoute(
                      builder: (context) => SampleItemDetailsView(item: item),
                    ),
                  )
                      .then((deleted) {
                    if (deleted ?? false) {
                      viewModel.removeItem(item.id);
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
