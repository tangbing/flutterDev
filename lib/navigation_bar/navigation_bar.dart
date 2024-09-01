import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterHub/constants/language.dart';
import 'package:flutterHub/l10n/localization_intl.dart';
import 'package:flutterHub/navigation_bar/widgets/translate_toggle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutterHub/constants/theme.dart';
import 'package:flutterHub/navigation_bar/widgets/explore_page.dart';
import 'package:flutterHub/navigation_bar/widgets/home_page.dart';
import 'package:flutterHub/navigation_bar/widgets/profile_page.dart';
import 'package:flutterHub/navigation_bar/widgets/setting_page.dart';
import 'package:flutterHub/navigation_bar/widgets/theme_model_toggle.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Watch((context) {
      List<String> locales = appLanguage.value.isoCode.split('_');
      debugPrint('locals: ${locales.first},${locales.last}');
      return MaterialApp(
        showSemanticsDebugger: false,
        themeMode: themeMode.value,
        theme: MaterialTheme(GoogleFonts.notoSansTextTheme()).light(),
        darkTheme: MaterialTheme(GoogleFonts.notoSansTextTheme()).dark(),
        localizationsDelegates:  [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          const LocaleNamesLocalizationsDelegate(),
          AppLocalizationsDelegate(),
        ],
        supportedLocales: Language.values.map((e) {
           List<String> lists = e.isoCode.split('_');
          return Locale(lists.first, lists.last);
        }),
        locale: Locale(locales.first, locales.last),
        localeResolutionCallback: (_locale, supportedLocales) {
          debugPrint(_locale.toString());
          // if () {
          //
          // } else {
          //   Locale? locale;
          //   if (supportedLocales.contains(locale)) {
          //     locale = _locale;
          //   } else {
          //     //如果系统语言不是中文简体或美国英语，则默认使用美国英语
          //     locale = const Locale('en', 'US');
          //   }
          //   return locale;
          // }
        },
        home: Scaffold(
          body: [HomePage(), ProfilePage(), ExplorePage(), SettingPage()][selectedIndex],
          // body: [
          //   Card(
          //     shadowColor: Colors.transparent,
          //     margin: EdgeInsets.all(8.0),
          //     child: SizedBox.expand(
          //       child: Center(
          //         child: Text(
          //           'Home page',
          //           style: theme.textTheme.titleLarge,
          //         ),
          //       ),
          //     ),
          //   ),
          //   const Padding(padding: EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Card(
          //           child: ListTile(
          //             leading: Icon(Icons.notifications_sharp),
          //             title: Text('Notification 1'),
          //             subtitle: Text('This is a notification'),
          //           ),
          //         ),
          //         Card(
          //           child: ListTile(
          //             leading: Icon(Icons.notifications_sharp),
          //             title: Text('Notification 2'),
          //             subtitle: Text('This is a notification'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   ListView.builder(
          //     reverse: true,
          //       itemCount: 12,
          //       itemBuilder: (context, index) {
          //        if (index == 0) {
          //          return Align(
          //            alignment: Alignment.centerRight,
          //            child: Container(
          //              margin: EdgeInsets.all(8.0),
          //              padding: EdgeInsets.all(8.0),
          //              decoration: BoxDecoration(
          //                color: theme.colorScheme.primary,
          //                borderRadius: BorderRadius.circular(8.0)
          //              ),
          //              child: Text(
          //                'Hello',
          //                style: theme.textTheme.bodyLarge?.copyWith(color:
          //                  theme.colorScheme.onPrimary
          //                ),
          //              ),
          //            ),
          //          );
          //        }
          //        return Align(
          //          child: Container(
          //            margin: const EdgeInsets.all(8.0),
          //            padding: const EdgeInsets.all(8.0),
          //            decoration: BoxDecoration(
          //              color: theme.colorScheme.primary,
          //              borderRadius: BorderRadius.circular(8.0),
          //            ),
          //            child: Text(
          //              'Hi!',
          //              style: theme.textTheme.bodyLarge!
          //                  .copyWith(color: theme.colorScheme.onPrimary),
          //            ),
          //          ),
          //        );
          //   }),
          // ][selectedIndex],
          bottomNavigationBar: NavigationBar(
            indicatorColor: Colors.amber,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Badge(isLabelVisible: false ,child: Icon(Icons.notifications_sharp)),
                label: 'Notifications',
              ),
              NavigationDestination(
                  icon: Badge(
                      label: Text('2'),
                      child: Icon(Icons.notifications_sharp)),
                  label: 'Messages'),
              NavigationDestination(
                selectedIcon: Icon(Icons.settings),
                icon: Icon(Icons.settings_outlined),
                label: 'Setting',
              ),
            ],
            // destinations: const [
            //   NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            //   NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
            //   NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            //   NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Setting')
            // ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) => setState(() {
              selectedIndex = index;
            }),
          ),
        ),
      );
    });
  }
}
