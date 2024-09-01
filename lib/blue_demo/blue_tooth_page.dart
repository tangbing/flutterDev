import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterHub/blue_demo/device_screen.dart';
import 'package:flutterHub/blue_demo/scan_result_tile.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BlueToothPage extends StatefulWidget {
  const BlueToothPage({super.key});

  @override
  State<BlueToothPage> createState() => _BlueToothPageState();
}

class _BlueToothPageState extends State<BlueToothPage> {
  ///当前已经连接的蓝牙设备
  List<BluetoothDevice> _systemDevices = [];
  ///扫描到的蓝牙设备
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    _scanResultsSubscription =
        FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      debugPrint('results:$results');
      _scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (error) {
      print('Scan Error:$error');
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((bool state) {
      debugPrint('state:$state');
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    }, onError: (error) {
      print('isScanning Error:$error');
    });
  }

  Future<void> onRefreshHandler() async {
    if (!_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      debugPrint('onStopPressed stopScan: ${e.toString()}');
    }
  }

  Future<void> onScanPressed() async {
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;
    } catch (e) {
      debugPrint('scanProcess systemDevices: ${e.toString()}');
    }

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      debugPrint('scanProcess startScan: ${e.toString()}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return FloatingActionButton(
        child: const Icon(Icons.stop),
        onPressed: onStopPressed,
        backgroundColor: Colors.red,
      );
    } else {
      return FloatingActionButton(child: const Text("SCAN"), onPressed: onScanPressed);
    }
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('bluetooth'),
        ),
        body: RefreshIndicator(
          onRefresh: onRefreshHandler,
          child: ListView(
            children: [
              ..._buildSystemDeviceTitles(),
              // ..._buildScanResultTiles(),
            ],
          ),
        ),
        floatingActionButton: buildScanButton(context),
      ),
    );
  }

  List<Widget> _buildSystemDeviceTitles() {
    return _systemDevices.map((device) {
      return ListTile(
        title: Text(device.platformName),
        subtitle: Text(device.remoteId.toString()),
        trailing: ElevatedButton(
          child: Text('Connect11'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DeviceScreen(device: device);
            }));
          },
        ),
      );
    }).toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (r) => ScanResultTile(
        result: r,
        onTap: () => onConnectPressed(r.device),
      ),
    )
        .toList();
  }

  void onConnectPressed(BluetoothDevice device) {
    print(device);
    // device.connectAndUpdateStream().catchError((e) {
    // //   // Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
    // });

    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) =>
        DeviceScreen(device: device)));

    // MaterialPageRoute route = MaterialPageRoute(
    //     builder: (context) => DeviceScreen(device: device), settings: RouteSettings(name: '/DeviceScreen'));
    // Navigator.of(context).push(route);
  }

  //   List<Widget> _buildScanResultTiles() {
  //   return _scanResults.map((scanResult) {
  //     return ListTile(
  //       title: Text(scanResult.device.platformName,
  //           overflow: TextOverflow.ellipsis),
  //       subtitle: Text(scanResult.device.remoteId.toString()),
  //       trailing: ElevatedButton(
  //         onPressed: () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     DeviceScreen(device: scanResult.device))),
  //         child: const Text('CONNECT'),
  //       ),
  //     );
  //   }).toList();
  // }
}
