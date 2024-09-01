

import 'package:flutter/material.dart';

class CountProvider extends InheritedWidget {

  final int count;
  final VoidCallback onIncrement;

  CountProvider({
    required this.count,
    required this.onIncrement,
    required Widget widget,
}) : super(child: widget);

  static CountProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CountProvider>()!;
  }
  @override
  bool updateShouldNotify(CountProvider oldWidget) {
    return count != oldWidget.count;
  }

}

class OffstageWidget extends StatefulWidget {
  const OffstageWidget({super.key});

  @override
  State<OffstageWidget> createState() => _OffstageWidgetState();
}

/*
Flutter 中的 Offstage 组件是一个非常有用的小部件,它可以控制它的子组件是否显示在屏幕上。
当 Offstage 的 offstage 属性为 true 时,其子组件将不会被渲染,也不会占用任何屏幕空间
 */
class _OffstageWidgetState extends State<OffstageWidget> {
  bool _isOffstage = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Offset Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  _isOffstage  =  !_isOffstage;
                });
              },
                  child: const Text('Toggle Offstage')),
              Offstage(
                offstage: _isOffstage,
                child: Container(
                  color: Colors.blue,
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Text('This is the hidden content'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 300,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );

  }
}


class FractionAllySizeWidget extends StatelessWidget {
  const FractionAllySizeWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Baseline(
                  baseline: 30.0,
                  baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Hello',
                  style: TextStyle(fontSize: 24,  backgroundColor: Colors.red),
                ),
              ),
              SizedBox(width: 10),
              Baseline(baseline: 30.0,
                  baselineType: TextBaseline.alphabetic,
                child: Text(
                  'World',
                  style: TextStyle(fontSize: 16, backgroundColor: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );

    // return  MaterialApp(
    //   home: Scaffold(
    //     body: ListWheelScrollView(
    //       itemExtent: 100,// 每个项目的高度
    //       diameterRatio: 1.5,// 滚轮直径与项目高度的比率
    //       offAxisFraction: 0.5,// 滚轮的倾斜角度
    //       children: List.generate(20, (index) =>
    //           Container(
    //             color: Colors.primaries[index % Colors.primaries.length],
    //             child: Center(
    //               child: Text('Item $index'),
    //             ),
    //           )
    //       ),
    //       // 当选中项目发生变化时的回调
    //       onSelectedItemChanged: (index) =>  print('Selected item: $index'),
    //     ),
    //   ),
    // );
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: SizedBox(
    //         width: 300,
    //         height: 300,
    //         child: ShaderMask(
    //           shaderCallback: (Rect bounds) {
    //             return const LinearGradient(
    //               tileMode: TileMode.clamp,
    //               begin: Alignment.topCenter,
    //                 end: Alignment.bottomCenter,
    //                 colors: [Colors.red, Colors.green],
    //             ).createShader(bounds);
    //           },
    //           child: const Text(
    //             'Gradient Text',
    //             style: TextStyle(
    //               fontSize: 48.0,
    //               fontWeight: FontWeight.bold
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         LimitedBox(
    //           maxWidth: 200,
    //           maxHeight: 100,
    //           child: Container(
    //             color: Colors.blue,
    //             width: 300,
    //             height: 300,
    //             child: Center(
    //               child: Text(
    //                 'LimitedBox',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: ConstrainedBox(
    //         constraints: BoxConstraints(
    //           minWidth: 100.0,
    //           minHeight: 100.0,
    //           maxWidth: 300.0,
    //           maxHeight: 300.0
    //         ),
    //         child: Container(
    //           color: Colors.red,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: Container(
    //         width: 300,
    //         height: 300,
    //         color: Colors.grey[200],
    //         child: FittedBox(
    //           fit: BoxFit.contain,
    //           child: Text('FittedBox 是一个很有用的布局组件,它可以帮助我们控制子组件的大小和位置,使其能够适应父容器的大小。',style: TextStyle(fontSize: 30)),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // return MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: Container(
    //         width: 300,
    //         height: 500,
    //         color: Colors.grey[200],
    //         child: FractionallySizedBox(
    //           widthFactor: 0.8,
    //           heightFactor: 0.6,
    //           child: Container(
    //             color: Colors.blue,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}


class MyAppWidget extends StatefulWidget {
  const MyAppWidget({super.key});

  @override
  State<MyAppWidget> createState() => _MyAppWidgetState();
}

class _MyAppWidgetState extends State<MyAppWidget> {
  int count  = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountProvider(
        count: 4,
        onIncrement: () => setState(() => count++),
        widget: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Count: ${CountProvider.of(context).count}'),
    );
  }
}



