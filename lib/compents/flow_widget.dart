

import 'package:flutter/material.dart';

class FlowWidget extends StatelessWidget {
  const FlowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Flow(
          delegate: MyFlowDelegate(),
          children: [
            Container(width: 100, height: 100, color: Colors.red),
            Container(width: 80, height: 80, color: Colors.green),
            Container(width: 120, height: 120, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx  = 0.0;
    double dy = 0.0;

    for (int i = 0; i < context.childCount; i++) {
      double width = context.getChildSize(i)!.width;
      double height = context.getChildSize(i)!.height;
      
      context.paintChild(i,
        transform: Matrix4.translationValues(dx, dy, 0.0),
      );

      dx += width + 16.0;
      if (dx + width + 16.0 > context.size.width) {
        dx = 0.0;
        dy += height + 16.0;
      }
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }

}
