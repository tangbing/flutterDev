import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoopScrollWidget extends StatefulWidget {
  final List<List<dynamic>> items;
  final double? rowHeight;
  final Widget Function(BuildContext context, int rowIndex, int index)
      itemBuilder;
  final void Function(BuildContext context, int rowIndex, int index)? itemClickHandler;

  const LoopScrollWidget({
    super.key,
    required this.items,
    this.rowHeight = 50,
    this.itemClickHandler,
    required this.itemBuilder,
  });

  @override
  State<LoopScrollWidget> createState() => _LoopScrollWidgetState();
}

class _LoopScrollWidgetState extends State<LoopScrollWidget> {
  late final List<ScrollController> _scrollControllers;
  late final List<bool> _isScrollingList;
  final double _scrollIncrement = 4.0;
  final Duration _scrollDuration = const Duration(milliseconds: 500);
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _scrollControllers = List.generate(widget.items.length, (index) {
      return ScrollController();
    });
    _isScrollingList = List.generate(widget.items.length, (index) => false);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _startAutoScroll();
    });
  }

  /*
  判断条件:

注释说明了如何判断是否有任何 ScrollPosition 对象附加到 ScrollController 上。
如果 ScrollPosition 对象附加到了 ScrollController 上，这个布尔值为 true；否则为 false。
方法调用限制:

如果没有 ScrollPosition 对象附加到 ScrollController 上（即布尔值为 false），以下方法不能被调用：
position: 获取当前的滚动位置。
offset: 获取当前的滚动偏移量。
animateTo: 动画滚动到指定位置。
jumpTo: 立即滚动到指定位置。
   */
  void _startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(_scrollDuration, (timer) {
      for (var i = 0; i < _scrollControllers.length; i++) {
        if (!_isScrollingList[i] && _scrollControllers[i].hasClients) {
          _scrollControllers[i].animateTo(
              _scrollControllers[i].offset + _scrollIncrement,
              duration: _scrollDuration,
              curve: Curves.linear);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.items.length, (rowIndex) {
        return GestureDetector(
          onPanDown: (_) => _isScrollingList[rowIndex] = true,
          onPanEnd: (_) => _isScrollingList[rowIndex] = false,
          onTapUp: (_) => _isScrollingList[rowIndex] = false,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // if (kDebugMode) {
              //   print('notification: $notification');
              // }
              if (notification is ScrollEndNotification) {
                _isScrollingList[rowIndex] = false;
              }
              return false;
            },
            child: SizedBox(
              height: widget.rowHeight,
              child: ListView.builder(
                  controller: _scrollControllers[rowIndex],
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final position = index % widget.items[rowIndex].length;
                    return Row(
                      children: [widget.itemBuilder(context, rowIndex, position)],
                    );
                  }),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class LoopScrollPageWidget extends StatefulWidget {
  const LoopScrollPageWidget({super.key});

  @override
  State<LoopScrollPageWidget> createState() => _LoopScrollPageWidgetState();
}

final List<List<String>> productReviews = [
  [
    '这件衣服质量很好',
    '喜欢非常满意',
    '性价比很高',
    '做工比较精细',
    '包装精美',
    '物超所值推荐',
    '非常好用',
    '款式非常漂亮',
    '服务周到',
    '物流迅速快',
  ],
  [
    '值得购买',
    '商品品质一流',
    '五星好评',
    '超级棒',
    '价格实惠',
    '收到货完美无缺',
    '非常贴心',
    '购物很满意',
    '推荐购买',
    '产品超出预期',
  ],
];

class _LoopScrollPageWidgetState extends State<LoopScrollPageWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('标签循环滚动控件'),
        ),
        body: Center(
          child: LoopScrollWidget(
            items: productReviews,
            // itemClickHandler: (context, int rowIndex, int index) {
            //   print('click: ${productReviews[rowIndex][index]}');
            // },
            itemBuilder: (BuildContext context, int rowIndex, int index) {
              return GestureDetector(
                onTap: () {
                  print('click: ${productReviews[rowIndex][index]}');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    productReviews[rowIndex][index],
                    style: const TextStyle(fontSize: 16, height: 1.1),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
