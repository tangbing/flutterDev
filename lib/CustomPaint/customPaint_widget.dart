import 'package:flutter/material.dart';

class CustompaintWidget extends StatelessWidget {
  const CustompaintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Canvas basic Drawing'),
        ),
        body: Center(
          child: CustomPaint(
            size: Size(300, 300),
            painter: MyPainter(),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔
    final paint = Paint();
    paint.color = Colors.blue;
    paint.strokeWidth = 4.0;

    // 绘制直线
    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);

    // 绘制矩形
    final rect = Rect.fromLTWH(50, 50, 100, 100);
    canvas.drawRect(rect, paint..color = Colors.red);
    // 绘制圆形
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50,
        paint..color = Colors.green);

    // 绘制椭圆
    final oval =  Rect.fromLTWH(150, 150, 100, 50);
    canvas.drawOval(oval,
        paint..color = Colors.orange);

    // 绘制弧线
    final arcRect  = Rect.fromCircle(
        center: Offset(size.width - 50, 50),
        radius: 40);
    canvas.drawArc(arcRect,
          0 , 3.14, true, paint..color = Colors.purple);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
