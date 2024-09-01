


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
identical() 用于检查两个引用是否指向同一对象

GlobalKey：全局唯一Key，每次build都不会重建，可以长期保持组件的状态，一般用于跨组件访问Widget的状态
   GlobalObjectKey: 重写了 equals() 和 hashCode() 方法，内部维护一个Object对象，通过判断此对象是否指向同一块内存地址来判断两个GlobalObjectKey是否相等
   LabeledGlobalKey:


LocalKey:
   valueKey: 部维护一个 泛型value属性，重写了==和hashCode()，如果两个ValueKey的 value属性相等，则认为两个Key相等。
   ObjectKey: 内部维护一个 Object?类型的value属性，同样重写了==和hashCode()，如果两个ObjectKey的 value属性指向同一对象，则认为两个Key相等
   UniqueKey： 独一无二的Key，没有属性也没重写==和hashCode()，那就是比较 UniqueKey 对象本身是否 指向同一个内存地址咯 来判断Key是否相等
   UniqueKey() 创建的Key唯一，所以组件的状态也得以保存。另外，它还有一个使用场景：
   强制Flutter框架 不复用旧的Widget而是重新创建，每次都会走initState()初始化状态；
 */


class TestKeyPage extends StatefulWidget {
   TestKeyPage({super.key});

  @override
  State<TestKeyPage> createState() => _TestKeyPageState();
}

class _TestKeyPageState extends State<TestKeyPage> {

  List<Widget> items = [
    // const TestKeyWidget(key: ValueKey(1), color: Colors.green),
    // const TestKeyWidget(key: ValueKey(2),  color: Colors.blue),
    // const TestKeyWidget(key: ValueKey(3),  color: Colors.red),

     TestKeyWidget(key: UniqueKey(), color: Colors.green),
     TestKeyWidget(key: UniqueKey(),  color: Colors.blue),
     TestKeyWidget(key: UniqueKey(),  color: Colors.red),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.remove),
          onPressed: () {
            items.removeAt(0);
            setState(() {});
          },
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ),
      ),
    );
  }
}

class TestKeyWidget extends StatefulWidget {
  const TestKeyWidget({super.key, required this.color});
  final Color color;

  @override
  State<TestKeyWidget> createState() => _TestKeyWidgetState();
}

class _TestKeyWidgetState extends State<TestKeyWidget> {
  int count =  0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: increment,
        child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }

  void increment(){
    setState(() {
      ++count;
    });
  }
}

