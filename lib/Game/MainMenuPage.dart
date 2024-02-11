

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:wordle_app/Game/GlobalVariables.dart';
import 'package:wordle_app/Game/WordlePage.dart';
import 'package:wordle_app/Widgets/DropDownWidget.dart';
import 'package:wordle_app/Widgets/ResponsivePadding.dart';
import 'package:wordle_app/Widgets/SwitchWidget.dart';
class mainMenuPage extends StatefulWidget {
  const mainMenuPage({super.key});

  @override
  State<mainMenuPage> createState() => _mainMenuPageState();
}

void AddWords() async{
  final response = await http.get(Uri.parse('https://gist.githubusercontent.com/mrhead/f0ced2726394588e8d9863e0568b6473/raw/89e48277775f30e60ff60592d6e3d4acfe733e10/wordle.json'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    List<String> descarga = [];
    for (String item in jsonList) {
      descarga.add(item.toUpperCase());
    }
    words = descarga;
  } else {
    throw Exception('Failed to load Words');
  }
}

class _mainMenuPageState extends State<mainMenuPage> {

  void loadDif() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    numFallos = preferences.getInt('intFallos') ?? 5;
  }
  void loadSound() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sonido = preferences.getBool('boolSound') ?? true;
    SetUpMusic();
  }

  @override
  void initState() {
    loadSound();
    loadDif();
    AddWords();
    super.initState();

  }


  @override
  void dispose(){
    player.dispose();
    super.dispose();
  }

  void goGameScene(BuildContext ctx){

    infiniteMode = false;
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
      return WordlePage();}));
  }
  void goGameSceneInfinite(BuildContext ctx){
    infiniteMode = true;
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
      numFallos = 100000;
      return WordlePage();}));
  }

  void settings(){
    showDialog(
        barrierColor: Colors.white.withOpacity(0.3),
        context: context, builder: (context)=> AlertDialog(
      insetPadding: EdgeInsets.only(bottom: 200,top:220),
      backgroundColor: Color(0xFFAEB8FE),
      actions: [
        TextButton(onPressed:(){Navigator.of(context).pop();},
            child: const Text("Back",style: TextStyle(fontSize: 30)),)
      ],
      title: const Text("Settings"),
      content: Column(

          children: <Container>[
            Container(child: Text("Sound",style: TextStyle(fontSize: 30,color: Colors.black))),
            Container(child: SwitchWidget()),
            Container(child: Text("Number of tries",style: TextStyle(fontSize: 30,color: Colors.black))),
            Container(child: DropDownWidget()),
          ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: MaterialApp(
          title: 'Wordle',

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

          ),
          home:  Scaffold(appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              title: Container(padding:const EdgeInsets.only(top:28),child: const Text("Wordle Menu",style: TextStyle(fontSize: 30,color: Colors.black))),
              backgroundColor: Color(0xFFFF8600),
              centerTitle: true,
              elevation: 0,
            ),
          ),
            body: Container(
              color:Colors.white,
              padding: const EdgeInsets.only(top:10),
              child: Column(

                children: [
                  Container(height: 200,width:double.infinity,padding:const EdgeInsets.only(top:50,left:5,right:5), child: ElevatedButton(onPressed: (){goGameScene(context);},style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF27187E)), child: Text("Play Normal Mode",style: TextStyle(fontSize: 20),),)),
                  Container(height: 200,width:double.infinity,padding:const EdgeInsets.only(top:50,left:5,right:5),child: ElevatedButton(onPressed:(){goGameSceneInfinite(context);} ,style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF27187E)), child: Text("Play Endless Mode",style: TextStyle(fontSize: 20),),)),
                  Container(height: 200,width:double.infinity,padding:const EdgeInsets.only(top:50,left:5,right:5),child: ElevatedButton(onPressed:(){settings();},style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF27187E)), child:Text("Settings",style: TextStyle(fontSize: 20),))),
                ],
              ),
            ),


          )

      ),
    );
  }
}