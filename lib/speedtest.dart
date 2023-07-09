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

    final List<Server> bestServer = [serversList[0]];

    setState(() {
      bestServersList = bestServer;
      country = bestServer[0].country;
      sponsor = bestServer[0].sponsor;
      readyToTest = true;
    });
  }
}
