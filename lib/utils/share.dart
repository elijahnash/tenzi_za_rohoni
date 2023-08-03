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
        songDetails += '$i:\n';
        for (String line in item['stanza_$i']) {
          songDetails += '$line\n';
        }
        songDetails += '\n';
      }
    }

    try {
      await FlutterShare.share(
        title: 'Share Song Details',
        text: songDetails,
        chooserTitle: 'Share via', // Title for the share popup
      );
    } catch (e) {
      // Error handling, if sharing fails
      print('Error sharing: $e');
    }
  }
}
