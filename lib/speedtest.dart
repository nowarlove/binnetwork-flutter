import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SpeedTestPage extends StatefulWidget {
  const SpeedTestPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpeedTestPageState createState() => _SpeedTestPageState();
}

class _SpeedTestPageState extends State<SpeedTestPage> {
  double downloadSpeed = 0.0;
  double uploadSpeed = 0.0;
  String speedStatus = '';

  @override
  void initState() {
    super.initState();
    measureSpeed();
  }

  Future<void> measureSpeed() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      // Mobile connection
      speedStatus = 'Mobile Connection';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // WiFi connection
      speedStatus = 'WiFi Connection';
    }

    setState(() {});

    // Simulating speed measurement
    await Future.delayed(const Duration(seconds: 3));

    // Placeholder values for download and upload speeds
    downloadSpeed = 50.0; // Mbps
    uploadSpeed = 20.0; // Mbps

    setState(() {
      speedStatus = getSpeedStatus(downloadSpeed);
    });
  }

  String getSpeedStatus(double speed) {
    const slowThreshold = 10.0; // Mbps
    const fastThreshold = 50.0; // Mbps

    if (speed < slowThreshold) {
      return 'Internet Speed: Slow';
    } else if (speed >= slowThreshold && speed <= fastThreshold) {
      return 'Internet Speed: Moderate';
    } else {
      return 'Internet Speed: Fast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Download Speed: ${downloadSpeed.toStringAsFixed(2)} Mbps',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            'Upload Speed: ${uploadSpeed.toStringAsFixed(2)} Mbps',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            speedStatus,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
