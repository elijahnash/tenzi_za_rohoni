import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTenzi extends StatelessWidget {
  const AboutTenzi({super.key});

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
              'Toleo 1.2.0',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tenzi za Rohoni ni programu inayokusanya tenzi za kiroho '
                'zinazotumiwa katika ibada na mikutano mbalimbali. '
                'Programu hii inatoa nafasi ya kusoma na kuimba tenzi hizi '
                'kwa urahisi na inaunganisha watu katika ibada pamoja. '
                'Kwa maswali au maoni, tafadhali wasiliana nasi kupitia:',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'tenzi_za_rohoni@mydeals.co.ke',
              style: TextStyle(color: Colors.amber[900]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to contact support via email or website.
                _sendEmail();
              },
              style: const ButtonStyle(),
              child: const Text('Wasiliana na Msaada'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'tenzi_za_rohoni@mydeals.co.ke',
      queryParameters: {
        'subject':
            'Maoni ya Programu: Tenzi za Rohoni', // You can customize the subject
        'body':
            'Habari, nina maoni kuhusu programu...', // Customize the email body
      },
    );

    if (await launchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      // Handle error: Could not launch email client
      if (kDebugMode) {
        print('Could not launch email client');
      }
    }
  }
}
