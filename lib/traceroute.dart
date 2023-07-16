import 'package:flutter/material.dart';
import 'package:flutter_traceroute/flutter_traceroute.dart';
import 'package:flutter_traceroute/flutter_traceroute_platform_interface.dart';

class TraceroutePage extends StatefulWidget {
  const TraceroutePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TraceroutePageState createState() => _TraceroutePageState();
}

class _TraceroutePageState extends State<TraceroutePage> {
  String domain = '';
  List<String> tracerouteResults = [];
  bool performingTraceroute = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'IP Address',
              hintText: 'Enter an IP address',
            ),
            onChanged: (value) {
              setState(() {
                domain = value;
              });
            },
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: performingTraceroute
                ? Colors.grey
                : Colors.blue,
          ),
          onPressed: performingTraceroute
            ? null
            : () { _performTraceroute(); },
          child: const Text('Perform Traceroute'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (String result in tracerouteResults) Text(result),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool isValidIpAddress(String ipAddress) {
    const pattern =
        r'^(([01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}([01]?\d{1,2}|2[0-4]\d|25[0-5])$';

    final regex = RegExp(pattern);
    return regex.hasMatch(ipAddress);
  }

  // Keterbatasan: Hanya bisa Tracerouting alamat IP
  void _performTraceroute() {
    if (domain.isNotEmpty) {
      tracerouteResults.clear();

      if (isValidIpAddress(domain)) {
        final traceroute = FlutterTraceroute();

        final stream = traceroute.trace(TracerouteArgs(host: domain));

        stream.listen((event) {
          setState(() {
            performingTraceroute = true;
            final result = event.toString();
            tracerouteResults.add(result);

            if (result.contains(domain)) {
              setState(() {
                performingTraceroute = false;
              });
            }
          });
        });
      } else {
        setState(() {
          tracerouteResults.add('Invalid IP address');
        });
      }
    }
  }
}
