import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/constants/connectivity_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkSensitiveWidget extends StatelessWidget {
  final Widget child;
  final double opacity;
  final ProviderBase connectivityStatusProvider;

  NetworkSensitiveWidget({
    required this.child,
    this.opacity = 0.5,
    required this.connectivityStatusProvider
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = context.read(connectivityStatusProvider);

    if ((connectionStatus == ConnectivityStatus.Cellular) ||
        (connectionStatus == ConnectivityStatus.WiFi)) {
      return child;
    }

    return IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }
}
