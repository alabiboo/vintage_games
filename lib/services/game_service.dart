
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http; 
import 'dart:async';

import 'package:vintage_games/constant/constants.dart';
import 'package:vintage_games/model/game-model.dart';

class  GameService{ 
  // Base headers for Response url
  static const Map<String, String> api_headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
    "x-rapidapi-key": API_KEY,
  };
   Future<List<Game>> getGameData() async {
     
    var url =Uri.https(BASE_LINK2, '/api/games');
    var client = http.Client(); 
    final response = await client.get(url, headers: api_headers); 
    try{
      if (response.statusCode == 200) {
        print("object TEST");
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