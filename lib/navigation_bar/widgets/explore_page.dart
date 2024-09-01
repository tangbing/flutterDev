import 'package:flutter/material.dart';
import 'package:flutterHub/l10n/localization_intl.dart';

enum DeviceStatus {
  all(null),
  offline(0),
  online(1),
  inactivated(-1);

  final int? code;

  const DeviceStatus(this.code);
}

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  final currentStatus = ValueNotifier<DeviceStatus>(DeviceStatus.all);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.explore ?? ''),

      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)?.explore ?? ''),
            ElevatedButton(
                onPressed: () => showBottomSheet(context), child: Text('show')),
          ],
        ),
      ),
    );
  }

  Future<void> showBottomSheet(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    showModalBottomSheet<void>(
        showDragHandle: true,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        useSafeArea: true,
        elevation: 10,

        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(6),
                child: Text(AppLocalizations.of(context)?.mdrStatus ?? '',
                    style: textTheme.headlineSmall),
              ),
              ...DeviceStatus.values.map((e) {
                return ValueListenableBuilder(
                    valueListenable: currentStatus,
                    builder: (context, status, child) {
                      return ListTile(
                          selected: e == status,
                          trailing: e == status
                              ? Icon(Icons.check)
                              : null,
                          title: Text(e.name),
                          onTap: () {
                            currentStatus.value = e;
                            Navigator.of(context).pop();
                          });
                    });
              })
            ].toList(),
          );
        });
  }
}
