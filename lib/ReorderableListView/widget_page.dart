

import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3'];


  Widget _buildItem(BuildContext context, int index) {
    print('_buildItem index: $index');
    return ListTile(
      key: ValueKey(_items[index]),
      title: Text(_items[index]),
    );
  }

  void _addItem() {
    setState(() {
      _items.add('Item  ${_items.length+ 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ReorderableListView'),
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: ReorderableListView.builder(
          onReorder: (int oldIndex, int newIndex) {
            print('old: $oldIndex, new: $newIndex');
            setState(() {
              if (oldIndex < newIndex) {
                newIndex  -= 1;
              }
              String item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
          itemBuilder: _buildItem,
          itemCount: _items.length,

        ),
      ),
    );
  }
}
