import 'dart:isolate';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterHub/CustomPaint/customPaint_widget.dart';
import 'package:flutterHub/DragTarget/my_drag_target_widget.dart';
import 'package:flutterHub/ReorderableListView/widget_page.dart';
import 'package:flutterHub/blue_demo/blue_tooth_page.dart';
import 'package:flutterHub/compents/flow_widget.dart';
import 'package:flutterHub/compents/keyed_subtree.dart';
import 'package:flutterHub/compents/myAppWidget.dart';
import 'package:flutterHub/key/test_key.dart';
import 'package:flutterHub/test_color_scheme/my_app.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'GroupListPage/group_list_page.dart';
import 'Matrix/matrix_widget.dart';
import 'keyboard/keyboard_widget.dart';
import 'learn/animation/animated_widget_example.dart';
import 'loop/loop_scroll_widget.dart';
import 'main_app.dart';
import 'navigation_bar/navigation_bar.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

mixin Swimmer {
  void swim() {
    print('Swimming');
  }
}

mixin Runner  {
  void run() {
    print('Running');
  }
}

class Human with Swimmer, Runner{}


/*
抽象类: 用于定义接口和公共功能，需要继承才能使用，适合定义一种类型的共同行为
混入：  用于在多个类之间共享功能，可以与多个类混合，适合添加辅助功能或者扩展现有类的功能。
 */
abstract class Animal {
  void eat();

  void sleep() {
    print('Sleeping');
  }
}

class Dog extends Animal {
  @override
  void eat() {
    print('Dog is eating');
  }
}

class ApiService {


  // 私有构造函数，防止外部 直接实例化
  ApiService._privateConstructor() {
    print('单例初始');
  }
  // 保存单例实例的静态变量
  static final ApiService _instance = ApiService._privateConstructor();
  // 工厂构造函数返回单例实例
  factory ApiService() => _instance;



  // 示例方法
  void fetchData() {
    print('Fetching data...');
  }


}

Future<void> main() async {
  print('main start-----------------');

  bool result = await doSomething();
  print('doSomething invoke');

  await doVoidSomething();
  print('doVoidSomething invoke');

  if (result)  {
    print('doSomething  true');
  }

  print('end-----------------');


  Human human = Human();
  human.swim();
  human.run();


  Dog dog = Dog();
  dog.eat();
  dog.sleep();

  // var api1 = ApiService._instance;
  var api1 = ApiService();

  var api2 = ApiService._instance;

  print(api1 == api2); // true, 因为它们是同一个实例

  api1.fetchData();
  // 输出 "Fetching data..."
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent)
  // );
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
  //   await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  // }
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  // 创建一个单位矩阵
  Matrix4 matrix4 = Matrix4.identity();
  // matrix4.rotateX(0.5);
  // matrix4.rotateY(0.5);
  matrix4.scale(2.0, 3.0, 1.0);

  // matrix4.rotateZ(0.5);// 旋转 0.5 弧度（约 28.65 度）
  // matrix4.translate(10.0, 20.0, 0.0);// 在 x 方向平移 10 像素，y 方向平移 20 像素
  print(matrix4);


  runApp(TestKeyPage());
}

Future<bool> doSomething() async {
  return Future.delayed(const Duration(seconds: 2), () {
    return true;
  });
}

Future<void> doVoidSomething() async {
  Future.delayed(const Duration(seconds: 2), () {
    if (kDebugMode) {
      print('2s second doVoidSomething pass');
    }
  });
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Localized Locales Example',
//       home: NavigationBarWidget(),
//     );
//   }
// }

// class LocaleListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<String> localeCodes = LocaleNames(locale, data).languageCodes;
//     List<String> localeNames = Locales.languageNames;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Localized Locales Example'),
//       ),
//       body: ListView.builder(
//         itemCount: localeCodes.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(localeNames[index]),
//             subtitle: Text(localeCodes[index]),
//           );
//         },
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const TestISOWidget(),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _timezone = 'Unknown';
  List<String> _availableTimezones = <String>[];
  int count = 0;

  @override
  void initState() {
    super.initState();

    final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
    print('year: ${moonLanding.year}');
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Local timezone app'),
        ),
        body: Column(
          children: <Widget>[
            Text('Local timezone: $_timezone\n'),
            Text('Available timezones:'),
            Badge.count(
                offset: Offset(0, 6),
                count: count,
                child: TextButton(
                    child: Text('badge'), onPressed: () => _updateBadgeNum())),
            Expanded(
              child: ListView.builder(
                itemCount: _availableTimezones.length,
                itemBuilder: (_, index) => Text(_availableTimezones[index]),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateBadgeNum() {
    debugPrint('_updageBadgeNum');
    setState(() {
      count = 999999;
    });
  }
}

class TestISOWidget extends StatefulWidget {
  const TestISOWidget({super.key});

  @override
  State<TestISOWidget> createState() => _TestISOWidgetState();
}

class _TestISOWidgetState extends State<TestISOWidget> {
  int count = 0;

  static Future<int> asyncCountEvent(int num) async {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  ///使用isolate的方式封装耗时操作
  Future<void> isolateCountEvent(int num) async {
    final p = ReceivePort();

    ///发送参数
    await Isolate.spawn(_entryPoint, [p.sendPort, num]);
    var aa = await p.first as int;

    setState(() {
      count = aa;
    });
  }

  static void _entryPoint(List<dynamic> args) async {
    SendPort responsePort = args[0];
    int num = args[1];

    /// 接收参数，进行耗时操作后返回数据
    int result = await asyncCountEvent(num);
    responsePort.send(result);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
          Text(count.toString()),
          TextButton(onPressed: () => print('aaa'), child: Text('aaaa')),
          TextButton(
              onPressed: () {
                isolateCountEvent(1000000000);
              },
              child: Text('开始耗时工作')),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    var time = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
