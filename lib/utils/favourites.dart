import 'package:flutter/material.dart';

class SaveFavs {
  List<Map<String, dynamic>> numbers = [];

  SaveFavs({required this.numbers});

  iter() {
    for (var number in numbers) {
      return Text("song_$number");
    }
  }
}
