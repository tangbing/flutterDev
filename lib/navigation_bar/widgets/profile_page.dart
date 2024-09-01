

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterHub/l10n/localization_intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.profile ?? ''),
      ),
      body: Center(child:Text(AppLocalizations.of(context)?.profile ?? ''),
      ),
    );
  }
}
