import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:signals/signals_flutter.dart';

final themeMode = signal(ThemeMode.system);

class ThemeModelToggle extends StatelessWidget {
  const ThemeModelToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((BuildContext context) {
      return IconButton(
          onPressed: () {
            themeMode.value = ThemeMode.values[(themeMode.value.index + 1) % ThemeMode.values.length];
          },
          icon: Icon(
             switch (themeMode.value) {
               ThemeMode.system => Symbols.brightness_auto,
               ThemeMode.light => Symbols.light_mode,
               ThemeMode.dark => Symbols.dark_mode,
             }
          ));
    }
    );
  }
}
