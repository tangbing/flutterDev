import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);

    return initializeMessages(localName).then((b) {
      Intl.defaultLocale = localName;
      return AppLocalizations();
    });
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

   String get home => Intl.message(
    'Home',
    name: 'home',
  );

  String get profile => Intl.message(
    'Profile',
    name: 'profile',
  );

  String get setting => Intl.message(
    'Setting',
    name: 'setting',
  );

  String get explore => Intl.message(
    'Explore',
    name: 'explore',
  );

  String get mdrStatus => Intl.message(
    'MdrStatus',
    name: 'mdrStatus',
  );

}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  /// 是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  /// Flutter会调用此类加载相应的Locale资源类
  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  /// 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
