import 'package:flutter/material.dart';
import 'package:whois/whois.dart';

class WhoisPage extends StatefulWidget {
  const WhoisPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WhoisPageState createState() => _WhoisPageState();
}

class _WhoisPageState extends State<WhoisPage> {
  String domain = '';
  String result = '';

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
            _getWhoisInfo();
          },
          child: const Text('Check Whois'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Text(result),
          ),
        ),
      ],
    );
  }

  Future<void> _getWhoisInfo() async {
    if (domain.isNotEmpty) {
      final data = await Whois.lookup(domain);
      setState(() {
        result = data.toString();
      });
    }
  }
}
