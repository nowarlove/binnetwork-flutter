import 'package:flutter/material.dart';

import 'sidebar.dart';
import 'information.dart';
import 'ping.dart';
import 'speedtest.dart';
import 'traceroute.dart';
import 'whois.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.information;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var container;
    if (currentPage == DrawerSections.information) {
      container = const InformationPage();
    } else if (currentPage == DrawerSections.ping) {
      container = const PingPage();
    } else if (currentPage == DrawerSections.speedtest) {
      container = const SpeedtestPage();
    } else if (currentPage == DrawerSections.traceroute) {
      container = const TraceroutePage();
    } else if (currentPage == DrawerSections.whois) {
      container = const WhoisPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 46, 204),
        title: const Text("BinNet"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Sidebar(),
              myDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Information", Icons.info_outline,
              currentPage == DrawerSections.information ? true : false),
          menuItem(2, "Ping", Icons.notifications_active_outlined,
              currentPage == DrawerSections.ping ? true : false),
          menuItem(3, "Speed Test", Icons.speed_outlined,
              currentPage == DrawerSections.speedtest ? true : false),
          menuItem(4, "Traceroute", Icons.track_changes_outlined,
              currentPage == DrawerSections.traceroute ? true : false),
          menuItem(5, "Whois", Icons.person_pin_circle_outlined,
              currentPage == DrawerSections.whois ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected
          ? const Color.fromARGB(189, 223, 60, 212)
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.information;
            } else if (id == 2) {
              currentPage = DrawerSections.ping;
            } else if (id == 3) {
              currentPage = DrawerSections.speedtest;
            } else if (id == 4) {
              currentPage = DrawerSections.traceroute;
            } else if (id == 5) {
              currentPage = DrawerSections.whois;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  information,
  ping,
  speedtest,
  traceroute,
  whois,
}
