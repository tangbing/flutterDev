//
//
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'dart:isolate';
//
// import 'package:async/async.dart';
//
// const filenames = [
//   'assets/json/json_01.json',
//   'assets/json/json_02.json',
//   'assets/json/json_03.json',
// ];
//
// void main() async {
//    await for (final jsonData in _sendAndReceive(filenames))  {
//       print('Received  JSON with ${jsonData.length} keys');
//     }
// }
//
// Stream<Map<String, dynamic>> _sendAndReceive(List<String>filenames) async* {
//   final p = ReceivePort();
//   // 启动子 Isolate，传递子 Isolate 的入口函数 _readAndParseJsonService 和 ReceivePort 的发送端 sendPort
//   await Isolate.spawn(_readAndParseJsonService, p.sendPort);
//   // 主 Isolate 发送文件名到子 Isolate
//
//   // StreamQueue：将 ReceivePort 转换为 StreamQueue，便于从子 Isolate 接收消息。
//   final events = StreamQueue<dynamic>(p);
//   // 接收子 Isolate 发送的 SendPort，用于向子 Isolate 发送消息。
//   SendPort sendPort = await events.next;
//
//   for (var filename in filenames) {
//     // 发送文件名到子 Isolate。
//     sendPort.send(filename);
//     // 等待子 Isolate 解析文件并返回 JSON 数据。
//     Map<String, dynamic> message = await events.next;
//
//     yield message;
//   }
//
//   sendPort.send(null);
//
//   await events.cancel();
//
// }
//
// // 子 Isolate 读取文件并解析 JSON
// Future<void> _readAndParseJsonService(SendPort p) async {
//   print('Sqawned isolate started.');
//   // 子 Isolate 创建一个 ReceivePort，用于接收主 Isolate 发送的文件名
//   final commandPort = ReceivePort();
//   //子 Isolate 发送 ReceivePort 的发送端 sendPort 给主 Isolate。
//   p.send(commandPort.sendPort);
//   //   子 Isolate 等待接收文件名
//   await for (final message in commandPort) {
//     if (message is String) {//  如果收到的是文件名，读取文件内容并解析为 JSON，然后发送回主 Isolate。
//       final contents = await File(message).readAsString();
//
//       p.send(jsonDecode(contents));
//     } else if (message == null) {//  如果收到 null，表示没有更多文件需要处理，退出循环并终止 Isolate。
//       break;
//     }
//   }
//   print('Spawned isolate finished.');
//   Isolate.exit();
// }

import 'package:flutter/material.dart';

/// Flutter code sample for [Overlay].

void main() => runApp(const OverlayApp());

class OverlayApp extends StatelessWidget {
  const OverlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OverlayExample(),
    );
  }
}

class OverlayExample extends StatefulWidget {
  const OverlayExample({super.key});

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample> {
  OverlayEntry? overlayEntry;
  int currentPageIndex = 0;

  void createHighlightOverlay({
    required AlignmentDirectional alignment,
    required Color borderColor,
  }) {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null);

    Widget builder(BuildContext context) {
      final (String label, Color? color) = switch (currentPageIndex) {
        0 => ('Explore page', Colors.red),
        1 => ('Commute page', Colors.green),
        2 => ('Saved page', Colors.orange),
        _ => ('No page selected.', null),
      };
      if (color == null) {
        return Text(label);
      }
      return Column(
        children: <Widget>[
          Text(label, style: TextStyle(color: color)),
          Icon(Icons.arrow_downward, color: color),
        ],
      );
    }

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // Align is used to position the highlight overlay
        // relative to the NavigationBar destination.
        return SafeArea(
          child: Align(
            alignment: alignment,
            heightFactor: 1.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Tap here for'),
                  Builder(builder: builder),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 80.0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Sample'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Use Overlay to highlight a NavigationBar destination',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // This creates a highlight Overlay for
              // the Explore item.
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentPageIndex = 0;
                  });
                  createHighlightOverlay(
                    alignment: AlignmentDirectional.bottomStart,
                    borderColor: Colors.red,
                  );
                },
                child: const Text('Explore'),
              ),
              const SizedBox(width: 20.0),
              // This creates a highlight Overlay for
              // the Commute item.
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentPageIndex = 1;
                  });
                  createHighlightOverlay(
                    alignment: AlignmentDirectional.bottomCenter,
                    borderColor: Colors.green,
                  );
                },
                child: const Text('Commute'),
              ),
              const SizedBox(width: 20.0),
              // This creates a highlight Overlay for
              // the Saved item.
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentPageIndex = 2;
                  });
                  createHighlightOverlay(
                    alignment: AlignmentDirectional.bottomEnd,
                    borderColor: Colors.orange,
                  );
                },
                child: const Text('Saved'),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              removeHighlightOverlay();
            },
            child: const Text('Remove Overlay'),
          ),
        ],
      ),
    );
  }
}
