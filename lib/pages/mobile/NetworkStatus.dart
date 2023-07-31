import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkStatus extends StatefulWidget {
  _NetworkStatusState createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  _init() async {
    _connectionStatus = await _connectivity.checkConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        print(event);
        setState(() {
          _connectionStatus = event;
        });
      },
    );
    setState(() {});
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network'),
      ),
      body: Center(
        child: Text('当前网络连接方式：${_connectionStatus.name}'),
      ),
    );
  }
}
