import 'package:flutter/material.dart';
import 'package:speed_test_dart/classes/server.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

class SpeedTestPage extends StatefulWidget {
  const SpeedTestPage({super.key});

  @override
  State<SpeedTestPage> createState() => _SpeedTestPageState();
}

class _SpeedTestPageState extends State<SpeedTestPage> {
  SpeedTestDart tester = SpeedTestDart();
  List<Server> bestServersList = [];

  String country = '';
  String sponsor = '';
  
  double lastDownloadRate = 0;
  double lastUploadRate = 0;

  bool readyToTest = false;
  bool loadingDownload = false;
  bool loadingUpload = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setBestServers();
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (readyToTest)
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Text(
                    'Test Server:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Country: $country'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('Host: $sponsor', textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          const Text(
            'Download Test:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (loadingDownload)
            const Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text('Testing download speed...'),
              ],
            )
          else
            Text('Download rate  ${lastDownloadRate.toStringAsFixed(2)} Mb/s'),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: readyToTest && !loadingDownload
                  ? Colors.blue
                  : Colors.grey,
            ),
            onPressed: loadingDownload
                ? null
                : () async {
                    if (!readyToTest || bestServersList.isEmpty) return;
                    await _performDownloadTest();
                  },
            child: const Text('Start'),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Upload Test:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (loadingUpload)
            const Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Testing upload speed...'),
              ],
            )
          else
            Text('Upload rate ${lastUploadRate.toStringAsFixed(2)} Mb/s'),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: readyToTest ? Colors.blue : Colors.grey,
            ),
            onPressed: loadingUpload
                ? null
                : () async {
                    if (!readyToTest || bestServersList.isEmpty) return;
                    await _performUploadTest();
                  },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  Future<void> _performDownloadTest() async {
      setState(() {
      loadingDownload = true;
      });
      final downloadRate =
          await tester.testDownloadSpeed(servers: bestServersList);
      setState(() {
        lastDownloadRate = downloadRate;
        loadingDownload = false;
      });
  }

  Future<void> _performUploadTest() async {
      setState(() {
        loadingUpload = true;
      });

      final uploadRate = await tester.testUploadSpeed(servers: bestServersList);

      setState(() {
        lastUploadRate = uploadRate;
        loadingUpload = false;
      });
  }

  Future<void> _setBestServers() async {
      final settings = await tester.getSettings();
      final servers = settings.servers;

      final serversList = await tester.getBestServers(
        servers: servers,
      );

      final List<Server> bestServer = [ serversList[0] ];

      setState(() {
        bestServersList = bestServer;
        country = bestServer[0].country;
        sponsor = bestServer[0].sponsor;
        readyToTest = true;
      });
    }
}
