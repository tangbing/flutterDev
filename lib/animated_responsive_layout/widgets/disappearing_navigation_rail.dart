import 'package:flutter/material.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/animation.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/destination.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/transitions/nav_rail_transition.dart';

import 'animated_floating_action_button.dart';

class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail({
       super.key,
      required this.railAnimation,
      required this.railFabAnimation,
      required this.backgroundColor,
      required this.selectedIndex,
      this.onDestinationSelected
  });

  final RailAnimation railAnimation;
  final RailFabAnimation railFabAnimation;
  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {

    return NavRailTransition(
      animation: railAnimation,
      backgroundColor: backgroundColor,
      child: NavigationRail(
          onDestinationSelected: onDestinationSelected,
          leading: Column(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              const SizedBox(height: 8),
              AnimatedFloatingActionButton(
                  animation: railFabAnimation,
                  elevation: 0,
                  child: const Icon(Icons.add),
                  onPressed: () {}),
            ],
          ),
          groupAlignment: -0.85,
          destinations: destinations.map((e) {
            return NavigationRailDestination(
                icon: Icon(e.icon), label: Text(e.label));
          }).toList(),
          selectedIndex: selectedIndex),
    );
  }
}
