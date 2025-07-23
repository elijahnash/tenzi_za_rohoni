import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTenzi extends StatelessWidget {
  const AboutTenzi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuhusu'),
        backgroundColor: Colors.amber[100],
        foregroundColor: Colors.amber[900],
        elevation: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.amber[50],
                      child: Image.asset(
                        'assets/images/coverwithoutshadow.png',
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Tenzi za Rohoni',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Toleo 2.0.1',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.brown,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Karibu kwenye Tenzi za Rohoni! Hii ni programu maalum iliyoundwa ili kukusanya na kuwezesha upatikanaji wa tenzi za kiroho zinazotumiwa katika ibada, mikutano, na hafla mbalimbali za Kikristo. Kwa urahisi, unaweza kusoma, kutafuta, na kuimba tenzi hizi popote ulipo. Lengo letu ni kukuza ibada na kuunganisha waumini kupitia nyimbo za kiroho. Asante kwa kutumia Tenzi za Rohoni!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 18),
                    Divider(color: Colors.amber[200], thickness: 1, height: 24),
                    const Text(
                      'Kwa maswali au maoni, tafadhali wasiliana nasi:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.brown),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: Colors.amber[800]),
                        const SizedBox(width: 6),
                        const Text(
                          'tenzi@liliputtech.com',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _sendEmail();
                          },
                          icon: const Icon(Icons.mail_outline),
                          label: const Text('Wasiliana Nasi'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.language),
                          color: Colors.amber[800],
                          tooltip: 'Tembelea Tovuti',
                          onPressed: () async {
                            final url = Uri.parse('https://liliputtech.com');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      '© 2025 LiliputTech',
                      style: TextStyle(color: Colors.amber[700], fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'tenzi@liliputtech.com',
      queryParameters: {
        'subject':
            'Maoni ya Programu: Tenzi za Rohoni', // You can customize the subject
        'body': '', // Customize the email body
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
