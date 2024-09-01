import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutterHub/constants/language.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';


const localeList = Language.values;
final appLanguage = signal<Language>(localeList.first);

class TranslateToggle extends StatelessWidget {
  const TranslateToggle({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: ${LocaleNames.of(context)!.nameOf(appLanguage.value.isoCode)}');
    return Watch((context) {
      return MenuAnchor(
          style: const MenuStyle(alignment: Alignment.centerRight),
          builder: (context, controller, widget) {
            return ListTile(
              title: const Text('Translate'),
              subtitle: Text(LocaleNames.of(context)!.nameOf(appLanguage.value.isoCode)!),
              leading: const Icon(Symbols.translate),
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
            );
          },
          menuChildren: localeList.map((e) {
            return MenuItemButton(
              trailingIcon:
              e == appLanguage.value ? const Icon(Symbols.check, fill: 1) : null,
              child: Text(e.name),
              onPressed: () {
                appLanguage.value = e;
              },
            );
          }).toList());
    },);
  }
}
