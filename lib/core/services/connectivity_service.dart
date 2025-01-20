import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/no_internet_screen.dart';

class ConnectivityService extends GetxController {
  final _connectivity = Connectivity();
  bool _isConnected = true;
  StreamSubscription? _subscription;

  bool get isConnected => _isConnected;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _startListening();
  }

  Future<void> _checkInitialConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _startListening() {
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _isConnected = result != ConnectivityResult.none;
    update();
  }

  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
    return result != ConnectivityResult.none;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
} 