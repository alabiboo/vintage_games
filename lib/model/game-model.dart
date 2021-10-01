class Game {
  
 final int id; 
 final String title;
 final String thumbnail;
 final String short_description;
 final String game_url; 
   

  Game({required this.id ,required this.title,required this.thumbnail ,
  required this.short_description,required this.game_url});
 

  toJson() {
    return {
      "id": id,
      "title": title,
      "thumbnail": thumbnail,
      "short_description": short_description,
      "game_url": game_url, 
    };
  }


  factory Game.fromJson(Map<String, dynamic> parsedJson) { 

    return  new Game(
      id: parsedJson['id'],
      title: parsedJson['title'],
      thumbnail: parsedJson['thumbnail'], 
      short_description: parsedJson['short_description'],
      game_url: parsedJson['game_url'], 
    );
  }
}
