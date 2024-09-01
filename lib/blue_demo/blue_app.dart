


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterHub/blue_demo/bluetooth_off_screen.dart';
import 'package:flutterHub/blue_demo/device_screen.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'blue_tooth_page.dart';

class FlutterBlueApp extends StatefulWidget {
  const FlutterBlueApp({super.key});

  @override
  State<FlutterBlueApp> createState() => _FlutterBlueAppState();
}

class _FlutterBlueAppState extends State<FlutterBlueApp> {

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
       _adapterState = state;
       if (mounted) {
         setState(() {});
       }
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = _adapterState == BluetoothAdapterState.on ? BlueToothPage() : BluetoothOffScreen();
    return MaterialApp(
      color: Colors.lightBlue,
      home: screen,
    );
  }
}
