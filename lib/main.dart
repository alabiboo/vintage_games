import 'package:flutter/material.dart';
import 'package:vintage_games/view-games.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Skill Builder',
      home: ViewGames() /*Scaffold(
        appBar: AppBar(
          title: const Text("Bruce’s Retro Games"),
        ),
        body: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(10, (index){
                return Container(
                  child: Text("data $index"),
                );
              }),
            ),
        ),*/
      
    );
  }
}
 