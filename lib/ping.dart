import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

class PingPage extends StatefulWidget {
  const PingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PingPageState createState() => _PingPageState();
}

class _PingPageState extends State<PingPage> {
  String ipAddress = '';
  String pingResult = '';

  Future<void> performPing() async {
    setState(() {
      pingResult = 'Pinging $ipAddress...\n';
    });

    final stream = NetworkAnalyzer.discover2(ipAddress, 1);

    await for (final NetworkAddress addr in stream) {
      if (addr.exists) {
        setState(() {
          pingResult += 'Reply from ${addr.ip}: time={duration}ms\n';
        });
      } else {
        setState(() {
          pingResult += 'Request timed out\n';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Ping",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              setState(() {
                ipAddress = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'IP Address or Host',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: performPing,
            child: const Text('Ping'),
          ),
          const SizedBox(height: 20),
          Text(pingResult),
        ],
      ),
    );
  }
}
