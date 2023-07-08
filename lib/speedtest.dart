import 'package:flutter/material.dart';

class SpeedtestPage extends StatelessWidget {
  const SpeedtestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          // Memulai pengukuran kecepatan internet
          startSpeedTest(context);
        },
        child: const Text('Run Speed Test'),
      ),
    );
  }

  void startSpeedTest(BuildContext context) {
    // Simulasi pengukuran kecepatan internet

    // Menunggu beberapa saat untuk simulasi pengukuran
    Future.delayed(const Duration(seconds: 5), () {
      // Pengukuran selesai
      double downloadSpeed = 10.5; // Kecepatan unduh dalam Mbps
      double uploadSpeed = 5.2; // Kecepatan unggah dalam Mbps

      // Menampilkan hasil kecepatan internet
      showSpeedTestResult(context, downloadSpeed, uploadSpeed);
    });
  }

  void showSpeedTestResult(
      BuildContext context, double downloadSpeed, double uploadSpeed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Speed Test Result'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Download Speed: $downloadSpeed Mbps'),
              const SizedBox(height: 10),
              Text('Upload Speed: $uploadSpeed Mbps'),
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// ignore: non_constant_identifier_names
RaisedButton({required Null Function() onPressed, required Text child}) {}

// ignore: non_constant_identifier_names
FlatButton({required Null Function() onPressed, required Text child}) {}
