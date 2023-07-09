import 'package:flutter/material.dart';
import 'package:dart_ping/dart_ping.dart';

class PingPage extends StatefulWidget {
  const PingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PingPageState createState() => _PingPageState();
}

class _PingPageState extends State<PingPage> {
  String _pingResult = '';
  final TextEditingController _ipController = TextEditingController();

  void _performPing() async {
    final ping = Ping(_ipController.text, count: 5);
    final pingStream = ping.stream;

    pingStream.listen((PingData pingData) {
      setState(() {
        _pingResult += '$pingData ms\n';
      });
    });
    await ping.stop();
  }

  void _clearOutput() {
    setState(() {
      _pingResult = '';
    });
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ping'),
        backgroundColor: const Color.fromARGB(255, 240, 69, 206),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: 'IP Address',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _performPing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 227, 114, 217),
                ),
                child: const Text('Perform Ping'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _clearOutput,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 227, 114, 217),
                ),
                child: const Text('Clear Output'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Text(_pingResult),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
