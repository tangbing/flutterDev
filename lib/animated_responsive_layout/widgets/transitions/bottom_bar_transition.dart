
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/animation.dart';

class BottomBarTransition extends StatefulWidget {
  const BottomBarTransition({
    super.key,
    required this.animation,
    required this.backgroundColor,
    required this.child
  });

  final Animation<double> animation;
  final Color backgroundColor;
  final Widget child;

  @override
  State<BottomBarTransition> createState() => _BottomBarTransitionState();
}

class _BottomBarTransitionState extends State<BottomBarTransition> {

  late Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero
  ).animate(OffsetAnimation(parent: widget.animation));


  late Animation<double> heightAnimation = Tween<double>(
    begin: 0,
    end: 1
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: heightAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
