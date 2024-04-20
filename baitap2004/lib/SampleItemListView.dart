import 'package:baitap2004/SampleItemDetailsView.dart';
import 'package:baitap2004/SampleItemUpdate.dart';
import 'package:baitap2004/SampleItemViewModel.dart';
import 'package:baitap2004/SampleItemWidget.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<String?>(
                context: context,
                builder: (context) => const SampleItemUpdate(),
              ).then((value) {
                if (value != null) {
                  viewModel.addItem(value);
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
              return SampleItemWidget(
                key: ValueKey(item.id),
                item: viewModel.items[index],
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
