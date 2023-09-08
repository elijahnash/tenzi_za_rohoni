import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class TenziSettings extends StatefulWidget {
  const TenziSettings({super.key});

  @override
  State<TenziSettings> createState() => _TenziSettingsState();
}

class _TenziSettingsState extends State<TenziSettings> {
  // Variables to store user preferences
  bool preventScreenOff = true;
  double textsize = 16.0;
  FontWeight fontWeight = FontWeight.normal;
  Color fontColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mipangilio"),
        backgroundColor: Colors.amber[600],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Zuia skrini isizime'),
            trailing: Switch(
              value: preventScreenOff,
              onChanged: (value) {
                setState(() {
                  preventScreenOff = value;
                  Wakelock.toggle(enable: preventScreenOff);
                });
              },
            ),
          ),
          // ListTile(
          //   title: Text('Ukubwa wa herufi'),
          //   trailing: Slider(
          //     value: textsize,
          //     min: 12.0,
          //     max: 24.0,
          //     onChanged: (value) {
          //       setState(() {
          //         textsize = value;
          //       });
          //     },
          //   ),
          // ),
          ListTile(
            title: const Text('Uzito wa herufi'),
            trailing: DropdownButton<FontWeight>(
              value: fontWeight,
              onChanged: (value) {
                setState(() {
                  fontWeight = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: FontWeight.normal,
                  child: Text('Fonti ya kawaida'),
                ),
                DropdownMenuItem(
                  value: FontWeight.bold,
                  child: Text('Fonti nzito'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
