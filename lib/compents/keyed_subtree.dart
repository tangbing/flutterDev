import 'package:flutter/material.dart';

/*
KeyedSubtree 是一个非常有用的组件,它可以帮助开发者解决一些常见的 Flutter 问题。
通过合理地使用 KeyedSubtree,开发者可以确保 Flutter 应用程序能够更好地处理动画、
状态管理等问题,从而提高应用程序的稳定性和性能。
 */
class MyWidgetPage extends StatefulWidget {
  const MyWidgetPage({super.key});

  @override
  State<MyWidgetPage> createState() => _MyWidgetPageState();
}

class _MyWidgetPageState extends State<MyWidgetPage> {
  final List<int> _items = [1, 2, 3, 4, 5];
  final _listKey = GlobalKey<AnimatedListState>();

  void _addItem() {
    setState(() {
      _items.add(_items.length + 1);
      _listKey.currentState?.insertItem(_items.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('非常用组件'),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: _addItem, child: const Text('Add Item')),
            Expanded(
                child: AnimatedList(
                  key: _listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, Animation<double> animation) {
                 return KeyedSubtree(
                   key: ValueKey(_items[index]),
                     child: SizeTransition(
                       sizeFactor: animation,
                       child: ListTile(
                         title: Text('Item ${_items[index]}'),
                       ),
                     ));
              },
            ))
          ],
        ),
      ),
    );
  }
}
