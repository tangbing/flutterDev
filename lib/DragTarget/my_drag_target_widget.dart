

import 'package:flutter/material.dart';

// 定义一个可拖拽的小球
class Draggableball extends StatelessWidget {
  const Draggableball({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
        data: 'ball',
        feedback: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue
          ),
        ),
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue
          ),
        ));
  }
}

// 定义一个可接受拖拽的目标区域
class DragTargetWidget extends StatefulWidget {
  const DragTargetWidget({super.key});

  @override
  State<DragTargetWidget> createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  Color _color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
        onAccept: (data) {
          setState(() {
            _color = Colors.green;
          });
        },
        
        onLeave: (data) {
          setState(() {
            _color = Colors.grey;
          });
        },
        builder: (context, list, builder) {
        return Container(
          width: 200,
          height: 200,
          color: _color,
          child: const Center(
            child: Text('Drop the ball here'),
          ),
        );
    });
  }
}

class MyDragTargetWidget extends StatelessWidget {
  const MyDragTargetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Draggable and DragTarget Example'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggableball(),
              SizedBox(height: 32),
              DragTargetWidget()
            ],
          ),
        ),
      ),
    );
  }
}



