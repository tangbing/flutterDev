import 'package:flutter/material.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/animation.dart';

class NavRailTransition extends StatefulWidget {
  const NavRailTransition(
      {super.key,
      required this.animation,
      required this.child,
      required this.backgroundColor});

  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;

  @override
  State<NavRailTransition> createState() => _NavRailTransitionState();
}

class _NavRailTransitionState extends State<NavRailTransition> {
  late final bool ltr = Directionality.of(context) == TextDirection.ltr;
  late Animation<Offset> offsetAnimation = Tween<Offset>(
          begin: ltr ? const Offset(-1, 0) : const Offset(1, 0),
          end: Offset.zero)
      .animate(OffsetAnimation(parent: widget.animation));

  late final Animation<double> widthAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: AnimatedBuilder(
          animation: widthAnimation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.topLeft,
              widthFactor: widthAnimation.value,
              child: FractionalTranslation(
                translation: offsetAnimation.value,
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}
