import 'package:flutter/material.dart';

class AboutTenzi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuhusu App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/coverwithoutshadow.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tenzi za Rohoni',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Toleo 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'App Yangu ni programu nzuri inayokusaidia kufanya mambo mazuri. '
              'Ina interface rahisi kutumia na huduma nyingi za kuvutia. '
              'Kwa msaada au maswali yoyote, tafadhali wasiliana nasi kupitia:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'support@example.com',
              style: TextStyle(color: Colors.amber[900]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to contact support via email or website.
              },
              style: const ButtonStyle(),
              child: const Text('Wasiliana na Msaada'),
            ),
          ],
        ),
      ),
    );
  }
}
