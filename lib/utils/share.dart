import 'package:flutter/foundation.dart';
import 'package:flutter_share/flutter_share.dart';

class SongShare {
  static void shareSongDetails(Map<String, dynamic> item) async {
    String songDetails = '';
    songDetails += '${item['song_number']}. ${item['title']}\n';
    songDetails += '${item['subtitle']}\n\n';

    for (int i = 1; i <= item.length - 4; i++) {
      if (i == 2) {
        if (item.containsKey('chorus')) {
          for (String line in item['chorus']) {
            songDetails += '$line\n';
          }
          songDetails += '\n';
        }
      }
      if (item.containsKey('stanza_$i')) {
        songDetails += '$i: ';
        for (String line in item['stanza_$i']) {
          songDetails += '$line\n';
        }
        songDetails += '\n';
        if (item.containsKey("chorus_$i")) {
          for (String line in item['chorus_$i']) {
            songDetails += '$line\n';
          }
        }
        songDetails += '\n';
      }
    }

    try {
      await FlutterShare.share(
        title: 'Shiriki wimbo',
        text: songDetails,
        chooserTitle: 'Shiriki kupitia', // Title for the share popup
      );
    } catch (e) {
      // Error handling, if sharing fails
      if (kDebugMode) {
        print('Error sharing: $e');
      }
    }
  }
}

class AppShare {
  static void shareApp() async {
    String shareTenziApp = '''
      Asante kwa kutumia Tenzi za Rohoni App! 🎶🙏

      Njoo ujisikie upako wa nyimbo za injili kutoka katika kitabu cha "Tenzi za Rohoni." Pata tenzi zako pendwa na usome mashairi ya nyimbo zinazokugusa moyo.

      Pakua App hii bure hapa: https://play.google.com/store/apps/details?id=ke.co.mydeals.tenzi_za_rohoni

      Tumia na ujumuishe wengine katika ibada yako. Neno la Bwana liendelee kutamalaki mioyoni mwetu!

      Barikiwa sana! 🌟✨

      https://play.google.com/store/apps/details?id=ke.co.mydeals.tenzi_za_rohoni: Tenzi za Rohoni
    ''';

    try {
      await FlutterShare.share(
          title: 'Shiriki App',
          text: shareTenziApp,
          chooserTitle: 'Shiriki kupitia');
    } catch (e) {
      if (kDebugMode) {
        print("Exception $e");
      }
    }
  }
}
