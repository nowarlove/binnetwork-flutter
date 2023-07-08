import 'package:flutter/material.dart';

class SpeedTestPage extends StatelessWidget {
  const SpeedTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speedtest'),
        backgroundColor: const Color.fromARGB(255, 240, 69, 206),
      ),
    );
  }
}
