
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http; 
import 'dart:async';

import 'package:vintage_games/constant/constants.dart';
import 'package:vintage_games/model/game-model.dart';

class  GameService{

 /* late List<Game> _games;
  List<Game> get games => _games;

  set gamelist(List<Game> value) {
    _games = value;
    notifyListeners();
  }*/

   Future<List<Game>> getGameData() async {
     
    var url =Uri.https(BASE_LINK, '/api/games');
    var client = http.Client();
   
    final response = await client.get(url); 
    try{
      if (response.statusCode == 200) {
        final parsed = convert.json.decode(response.body).cast<Map<String, dynamic>>();
        
        return parsed.map<Game>((json) => Game.fromJson(json)).toList();
        
      } else {
        throw Exception("Failed to load Data");
      }
    }finally{
      client.close();
    }
  }
}