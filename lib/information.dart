import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  String _connectionType = 'Unknown';
  String _ipAddress = 'Unknown';
  String _subnetMask = 'Unknown';
  String _defaultGateway = 'Unknown';
  String _ipv6Address = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getNetworkInformation();
  }

  Future<void> _getNetworkInformation() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _connectionType = 'No connection';
      });
      return;
    }

    final networkInfo = NetworkInfo();
    final wifiName = await networkInfo.getWifiName();
    final ipAddress = await networkInfo.getWifiIP();
    final subnetMask = await networkInfo.getWifiSubmask();
    final defaultGateway = await networkInfo.getWifiGatewayIP();
    final ipv6Address = await networkInfo.getWifiIPv6();

    if (wifiName != null) {
      setState(() {
        _connectionType = 'No connection';
        _ipAddress = 'Unknown';
        _subnetMask = 'Unknown';
        _defaultGateway = 'Unknown';
        _ipv6Address = 'Unknown';
      });
    } else {
      setState(() {
        _connectionType = 'Wi-Fi';
        _ipAddress = ipAddress ?? 'Unknown';
        _subnetMask = subnetMask ?? 'Unknown';
        _defaultGateway = defaultGateway ?? 'Unknown';
        _ipv6Address = ipv6Address ?? 'Unknown';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        backgroundColor: const Color.fromARGB(255, 240, 69, 206),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getNetworkInformation,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Connection Type: $_connectionType',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'IP Address: $_ipAddress',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Subnet Mask: $_subnetMask',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Default Gateway: $_defaultGateway',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'IPv6 Address: $_ipv6Address',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
