import 'package:flutter/material.dart';

class TenziSettings extends StatefulWidget {
  const TenziSettings({super.key});

  @override
  State<TenziSettings> createState() => _TenziSettingsState();
}

class _TenziSettingsState extends State<TenziSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mipangilio"),
        backgroundColor: Colors.amber[600],
      ),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mipangilio",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
