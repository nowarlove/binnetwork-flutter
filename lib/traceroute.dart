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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Domain Name',
              hintText: 'Enter a domain name',
            ),
            onChanged: (value) {
              setState(() {
                domain = value;
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _performTraceroute();
          },
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

  Future<void> _performTraceroute() async {
    if (domain.isNotEmpty) {
      tracerouteResults.clear();
      final traceroute = FlutterTraceroute();

      try {
        final List<dynamic> hops =
            await traceroute.trace(TracerouteArgs(host: domain)).toList();

        // ignore: unused_local_variable
        for (TracerouteStep hop in hops) {
          setState(() {
            // ignore: prefer_typing_uninitialized_variables
            var hop;
            tracerouteResults.add('Hop: ${hop.hop}, IP: ${hop.ip}');
          });
        }
      } catch (e) {
        setState(() {
          tracerouteResults.add('Error: $e');
        });
      }
    }
  }
}
