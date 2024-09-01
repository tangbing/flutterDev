
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart'  as math;
class MatrixWidget extends StatelessWidget {
  const MatrixWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 创建一个矩形
    Matrix4 matrix4 = math.Matrix4.identity();
    matrix4.translate(50.0, 100.0);
    matrix4.rotateZ(math.radians(45));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Matrix Transformation'),
        ),
        body: Center(
          child: Transform(
            transform: matrix4,
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
