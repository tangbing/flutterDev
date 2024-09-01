import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterHub/animated_responsive_layout/models/data.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/animated_floating_action_button.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/animation.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/destination.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/disappearing_bottom_navigation_bar.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/disappearing_navigation_rail.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/email_list_view.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/list_detail_transition.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/reply_list_view.dart';
import 'package:flutterHub/constants/theme.dart';
import 'package:flutterHub/navigation_bar/widgets/setting_page.dart';

import 'animated_responsive_layout/models/models.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      themeMode: ThemeMode.light,
      theme: MaterialTheme(GoogleFonts.notoSansTextTheme()).light(),
      darkTheme: MaterialTheme(GoogleFonts.notoSansTextTheme()).dark(),
      home: Feed(currentUser: user_0),
    );
  }
}

class Feed extends StatefulWidget {
  const Feed({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
      _colorScheme.primary.withOpacity(0.14), _colorScheme.surface);
  int selectedIndex = 0;
  bool controllerInitialized = false;

  late final _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1250),
      value: 0,
      vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double width = MediaQuery.of(context).size.width;

    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: [
            Row(
              children: [
                DisappearingNavigationRail(
                  railAnimation: _railAnimation,
                  railFabAnimation: _railFabAnimation,
                  selectedIndex: selectedIndex,
                  backgroundColor: _backgroundColor,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    color: _backgroundColor,
                    child: ListDetailTransition(
                      animation: _railAnimation,
                      one: EmailListView(
                        selectedIndex: selectedIndex,
                        onSelected: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        currentUser: widget.currentUser,
                      ),
                      two: const ReplyListView(),
                    ),
                  ),
                )
              ],
            ),
          ][selectedIndex],
          floatingActionButton: AnimatedFloatingActionButton(
            animation: _barAnimation,
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: DisappearingBottomNavigationBar(
              onDestinationSelected: (index) {
                debugPrint('select index: $index');
                setState(() {
                  selectedIndex = index;
                });
              },
              selectedIndex: selectedIndex,
              barAnimation: _barAnimation),
        );
      },
    );
  }
}
