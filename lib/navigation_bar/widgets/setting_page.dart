

import 'package:flutter/material.dart';
import 'package:flutterHub/l10n/localization_intl.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutterHub/navigation_bar/widgets/theme_model_toggle.dart';
import 'package:flutterHub/navigation_bar/widgets/translate_toggle.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // final browser = ChromeSafariBrowser();

  final packageInfo = signal(
    PackageInfo(appName: 'Unknown',
        packageName: 'Unknown',
        version: 'Unknown',
        buildNumber: 'Unknown'
    ),
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    packageInfo.value = await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.setting ?? ''),
        actions: const [ThemeModelToggle()],
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            const TranslateToggle(),
            const Divider(),
            Watch((context) {
              return ListTile(
                title: const Text('App version'),
                subtitle: Text('${packageInfo.value.version}.${packageInfo.value.buildNumber}'),
              );
            }),
            ListTile(
              title: const Text('Privacy Policy'),
              onTap: () {
                // browser.open(
                //   url: WebUri.uri(Uri.parse('https://www.mettaxiot.com/html/mctool/PrivacyPolicy.html')),
                // );
              },
            ),
            ListTile(
              title: const Text('Registration and Service Agreement'),
              onTap: () {
                // browser.open(
                //   url: WebUri.uri(Uri.parse('https://www.mettaxiot.com/html/mctool/RegistrationandServiceAgreement.html'))
                // );
              },
            ),
            Watch((context) => AboutListTile(
              applicationName: packageInfo.value.appName,
              applicationVersion: '${packageInfo.value.version}.${packageInfo.value.buildNumber}',
              applicationIcon: Image.asset('assets/avatar_1.png', width: 48, height: 48),
              applicationLegalese:
              'Configurator for 4G DashCam or MDVR devices.\n© 2023 MettaX',
            )),
          ],
        ),
      ),
    );
  }
}
