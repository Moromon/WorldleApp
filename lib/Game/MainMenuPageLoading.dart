/*



import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wordle_app/Game/GlobalVariables.dart';
import 'package:wordle_app/Game/WordlePage.dart';
class mainMenuPage extends StatefulWidget {
  const mainMenuPage({super.key});

  @override
  State<mainMenuPage> createState() => _mainMenuPageState();
}

Future<List> AddWords() async{
  final response = await http.get(Uri.parse('https://gist.githubusercontent.com/mrhead/f0ced2726394588e8d9863e0568b6473/raw/89e48277775f30e60ff60592d6e3d4acfe733e10/wordle.json'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    List<String> descarga = [];
    for (String item in jsonList) {
      descarga.add(item.toUpperCase());
    }
    words = descarga;
    return descarga;
  } else {
    throw Exception('Failed to load Character');
  }
}

class _mainMenuPageState extends State<mainMenuPage> {


  @override
  void initState(){
    super.initState();
    wordsFuture = AddWords();
  }

  void goGameScene(BuildContext ctx){
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
      return WordlePage();}));
  }


  late Future<List> wordsFuture;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<List>(
        future: wordsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(appBar: AppBar(
              title: const Text("Worlde Menu"),
              centerTitle: true,
              elevation: 0,
            ),
              body: Column(
                children: [
                  Center(child: Text("Menu Pricipal")
                  ),ElevatedButton(onPressed: (){goGameScene(context);}, child: Text("Play"))
                ],
              ),


            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

*/