

import 'package:flutter/material.dart';

class MyColorSchemeApp extends StatelessWidget {
  const MyColorSchemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: MyHomePageee(),
    );
  }
}

class MyHomePageee extends StatelessWidget {
  const MyHomePageee({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('ColorScheme Example'),
        backgroundColor: colorScheme.primary,
      ),
      body: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,

            ),
            onPressed: () {  },
            child: Text('primary'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.secondary,

            ),
            onPressed: () {  },
            child: Text('secondary'),
          )
        ],
      ),
    );
  }
}

