import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/game-model.dart';
import 'services/game_service.dart';

class ViewGames extends StatefulWidget { 
  const ViewGames({ Key? key }) : super(key: key);

  @override
  _ViewGamesState createState() => _ViewGamesState();
}

class _ViewGamesState extends State<ViewGames> {

  TextEditingController searchTextController = new TextEditingController();

  bool isLoading = false;
  static GameService gservice = new GameService();
    List<Game> gameOriginalList =  [
      Game(game_url:  "imageUrl1", title: "one", id: 1, short_description: "", thumbnail: ""), 
      Game(game_url: "imageUrl2", title: "two", id: 1, short_description: "", thumbnail: ""),
      Game(game_url: "imageUrl3", title: "three", id: 1, short_description: "", thumbnail: ""),
      Game(game_url: "imageUrl4", title: "four", id: 1, short_description: "", thumbnail: ""),
      Game(game_url: "imageUrl5", title: "five", id: 1, short_description: "", thumbnail: ""),
    ];
    List<Game> gameTempList = [];
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gameTempList=gameOriginalList; 
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    gameOriginalList.clear();
    var a = await gservice.getGameData(); 
    for (var item in a) {
      gameOriginalList.add(item); 
    }
    setState(() {
      gameTempList=gameOriginalList;
      isLoading= false;
    });
    
    
  }


  Widget cartviewwidget(Game game){
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [ 
        Container( 
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Colors.blueAccent) 
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(game.thumbnail),
                        ),
                      ),
                    ), 
                    Text(game.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                  ],
                ),
          ),
          Container( 
            margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
          child: Icon(Icons.favorite, color: Colors.red,)),
      ],
    );
  }
  SliverAppBar createSilverAppBarOne() {
    return SliverAppBar(
      backgroundColor: Colors.blueAccent,
      expandedHeight: 300,
      floating: false,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: Text("Bruce’s Retro Games"),
              centerTitle: true,
              background: Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/game.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }

  SliverAppBar createSilverAppBarTwo() {
    return SliverAppBar(
      backgroundColor: Colors.blueAccent,
      pinned: true,
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          controller: searchTextController,
          onChanged :(value) {
            if(value != ""){
              setState(() {  
                gameTempList = gameOriginalList.where((element) => element.title.toUpperCase().contains(searchTextController.text.toUpperCase())).toList();
              });
            }else{
              setState(() {
                gameTempList = gameOriginalList; 
              });
            }
          },
          keyboardType: TextInputType.text,
          placeholder: 'Search game',
          placeholderStyle: TextStyle(
            color: Colors.blueGrey,
            fontSize: 14.0, 
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading 
      ? Center(child: CircularProgressIndicator()) 
      : NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              createSilverAppBarOne(),
              createSilverAppBarTwo()
            ];
          },
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: searchTextController.text != '' ? 
            ListView.builder(
              itemCount: gameTempList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50.0) 
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(gameTempList[index].thumbnail),
                        ),
                      ),
                    ),
                    title: Text(gameTempList[index].title, style: TextStyle(fontSize: 18.0),),
                    trailing: Icon(Icons.favorite, color: Colors.red,),
                  ),
                );
              })
             : GridView.count(
                  shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(gameTempList.length, (index){
                        return cartviewwidget(gameTempList[index]);
                      }),
                    ),)),
    ); 
  }
}