import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineBanner extends StatefulWidget {
  final Widget child;
  final Duration checkInterval;

  const OfflineBanner({
    super.key,
    required this.child,
    this.checkInterval = const Duration(seconds: 10),
  });

  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner> {
  bool _isOffline = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    } as void Function(List<ConnectivityResult> event)?) as StreamSubscription<ConnectivityResult>;

    // Periodically check connectivity
    _timer = Timer.periodic(widget.checkInterval, (timer) {
      _checkConnectivity();
    });
  }

  Future<void> _checkConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      _updateConnectionStatus(connectivityResult as ConnectivityResult);
    } catch (e) {
      print('Error checking connectivity: $e');
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isOffline = result == ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isOffline)
          Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: const Text(
              'You are offline. Some features may not be available.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Expanded(child: widget.child),
      ],
    );
  }
}