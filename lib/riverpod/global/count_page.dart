


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'count_page.g.dart';

/*
① 创建一个 全局final 的 Provider实例 来存储 状态/数据，传入一个 初始化状态的方法。
② 使用 ProviderScope 包裹 MyApp 实例。
③ 需要用到状态的 Widget 继承 ConsumerWidget，它的 build() 会提供一个 WidgetRef 类型的参数。
④ 需要 读取状态值，调用 ref.watch(xxxProvider) 来获取，状态值改变，会触发UI更新。
⑤ 需要 修改状态值， 调用 ref.read(xxxProvider.notifier).state = xxx。

作者：coder_pig
链接：https://juejin.cn/post/7359402114018689076
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
// final clickCountProvider = StateProvider<int>((ref) => 0);

//  代码生成 方式
// @Riverpod(keepAlive: true)
// int clickCount(ClickCountRef ref) => 0;


// class ClickCount  extends Notifier<int>  {
//   @override
//   int build() => 0;
//
//   void increment() {
//     state++;
//   }
// }
//
// final clickCountProvider = NotifierProvider<ClickCount, int>(() {
//  return ClickCount();
// });

//  代码生成方式NotifierProvider
@Riverpod(keepAlive: true)
class ClickCount extends _$ClickCount {
  @override
  int build() => 0;

  void increment() {
    state++;
  }
}


void  main() {
  runApp(const  ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count =  ref.watch(clickCountProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod Demo'),
        ),
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('点击计数：$count'),
                  ElevatedButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const CountPage())
                    );
                  },
                      child: const Text('跳转到增加计数页面'))
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

class CountPage extends ConsumerWidget {
  const CountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count =  ref.watch(clickCountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('增加计数'),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('点击计数：$count'),
                ElevatedButton(onPressed: () {
                 // ref.read(clickCountProvider.notifier).state++;
                  ref.read(clickCountProvider.notifier).increment();
                },
                    child: const Text('点击计数+1'))
              ],
            );
          }
        ),
      ),
    );
  }
}

