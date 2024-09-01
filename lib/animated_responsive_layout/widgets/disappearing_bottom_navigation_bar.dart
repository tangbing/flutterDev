

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/animation.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/destination.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/transitions/bottom_bar_transition.dart';

class DisappearingBottomNavigationBar extends StatelessWidget {
  const DisappearingBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
    required this.barAnimation
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final BarAnimation barAnimation;

  @override
  Widget build(BuildContext context) {
    return BottomBarTransition(
      animation: barAnimation,
      backgroundColor: Colors.white,
      child: NavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          destinations: destinations.map((e) {
            return NavigationDestination(icon: Icon(e.icon), label: e.label);
          }).toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
