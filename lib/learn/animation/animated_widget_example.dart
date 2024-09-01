
import 'package:flutter/material.dart';
import 'package:flutterHub/learn/animation/spinning_container.dart';

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({super.key});

  @override
  State<AnimatedWidgetExample> createState() => _AnimatedWidgetExampleState();
}



class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample> with TickerProviderStateMixin {
  
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
      vsync: this);
   late Animation<double> animation = Tween(begin: 0.0, end: 300.0).animate(_controller);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.forward();

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
            child: GrowTransition(
                    animation: animation,
            child: Container(
              color: Colors.red,
            )),
          )
        ),
    );
  }
}
