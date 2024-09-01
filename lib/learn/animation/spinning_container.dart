import 'package:flutter/material.dart';
import 'dart:math' as math;

// class SpinningContainer extends AnimatedWidget {
//   const SpinningContainer({
//     super.key,
//     required AnimationController controller,
//   }) : super(listenable: controller);
//
//
//   Animation<double> get _progress => listenable as Animation<double>;
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('progress: ${_progress.toString()}');
//     return Transform.rotate(
//       angle: -math.pi / 12.0,
//       child: Container(width: 200.0, height: 200.0, color: Colors.green),
//     );
//   }
// }

class GrowTransition extends StatelessWidget {
  const GrowTransition({super.key, this.child, required this.animation});

  final Widget? child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SizedBox(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
      child: child,
    );
  }
}
