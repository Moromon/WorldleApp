

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/Game/GameController.dart';
import 'package:wordle_app/Game/GlobalVariables.dart';
import 'package:wordle_app/Game/MainMenuPage.dart';
import 'package:wordle_app/Game/answerStates.dart';

import '../Widgets/KBRow.dart';
import '../Widgets/WordGrid.dart';

class WordlePage extends StatefulWidget {
  const WordlePage({super.key});


  @override
  State<WordlePage> createState() => _WordlePageState();


}

class _WordlePageState extends State<WordlePage> {

  bool win = false;
  late String _word;
  String endGameText= "";

  final controllerConfetti = ConfettiController();

  @override
  void initState(){
    keysMap.clear();
    entrys.clear();

    keysMap = keysMapBase.map((key, value) => MapEntry(key, value));
    final r = Random().nextInt(words.length);
    _word = words[r];
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<GameController>(context,listen: false).setCorrectWord(_word);
      Notify();
    });
    print(_word);
    super.initState();

  }
  void Notify(){
    Provider.of<GameController>(context, listen: false).notifyListeners();
  }
  void goMenuScene(BuildContext ctx){
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
      return mainMenuPage();}));
  }
  @override
  void dispose(){
    super.dispose();
    controllerConfetti.dispose();
  }
  void ShowResults() async {

    if(win){
      controllerConfetti.play();
    }

    Future.delayed(const Duration(milliseconds: 1000),(){

      showDialog(
          barrierColor: Colors.white.withOpacity(0.3),
          context: context, builder: (context)=> AlertDialog(
        actions: [
          TextButton(onPressed:(){goMenuScene(context);},
            child: const Text("Menu",style: TextStyle(fontSize: 20)),)
        ],
        title: const Text("Results",style: TextStyle(fontSize: 30)),
        content: Text(endGameText,style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
        contentPadding: const EdgeInsets.all(50.0),
      ));
    });


  }
  void WordError() async {
      showDialog(
          barrierColor: Colors.white.withOpacity(0.3),
          context: context, builder: (context)=> AlertDialog(
        actions: [
          TextButton(onPressed:(){Navigator.of(context).pop();},
              child: const Text("Back",style: TextStyle(fontSize: 20)))
        ],
        title: const Text("Word does not exist"),
        contentPadding: const EdgeInsets.all(50.0),
      ));



  }

  @override
  Widget build(BuildContext context) {

    int indx =0;
    int row =0;
    checkResolve(){
      List<String> wordCheck = [];
      List<String> missplacedLetters = [];
      String finalWord = "";

      for(int i =row*5;i<(5*row)+5;i++){
        wordCheck.add(entrys[i].letter);
      }

      if(!words.contains(wordCheck.sublist(0, 5).join())){
        WordError();
        return false;
      }
      finalWord = wordCheck.join();
      missplacedLetters = _word.characters.toList();

      if(finalWord == _word){
        for(int i =row*5;i<(5*row)+5;i++){
          entrys[i].state = AnswerStates.correct;
          keysMap.update(entrys[i].letter, (value) => AnswerStates.correct);
          endGameText = "Congrats, you win";
          win = true;
          ShowResults();

        }
      }else{
        for(int i = 0;i<5;i++){
          if(finalWord[i] == _word[i]){
            missplacedLetters.remove(finalWord[i]);
            entrys[i+(row*5)].state = AnswerStates.correct;
            keysMap.update(entrys[i+(row*5)].letter, (value) => AnswerStates.correct);
          }
        }
        for(int i =0;i<missplacedLetters.length;i++){
          for(int j = 0;j<5;j++){
            if(missplacedLetters[i] == entrys[j+(row*5)].letter){
              if(entrys[j+(row*5)].state != AnswerStates.correct){
                if((keysMap.entries.where((element)=>element.key == entrys[j+(row*5)].letter)).single.value != AnswerStates.correct){
                  entrys[j+(row*5)].state = AnswerStates.contains;
                  keysMap.update(entrys[j+(row*5)].letter, (value) => AnswerStates.contains);
                  }
                }

                final resultKey = keysMap.entries.where((element)=>element.key == entrys[j+(row*5)].letter);
                if(resultKey.single.value !=AnswerStates.correct){
                  keysMap.update(resultKey.single.key, (value) => AnswerStates.contains);
                }
            }
          }
        }
        for(int i = 0;i<finalWord.length;i++){
          for(int j = 0;j<5;j++){
            if(finalWord[i] == entrys[j+(row*5)].letter){
              if(entrys[j+(row*5)].state==AnswerStates.notAnswered){
                if((keysMap.entries.where((element)=>element.key == entrys[j+(row*5)].letter)).single.value == AnswerStates.notAnswered){
                  keysMap.update(entrys[j+(row*5)].letter, (value) => AnswerStates.incorrect);
                }

              }
            }
          }
        }
      }
      Provider.of<GameController>(context, listen: false).lineCompleted();
      return true;
    }
    keyEnter(String s){
      if(s == "ENTER"){
        if(indx ==5 *(row+1)){
          if(checkResolve()){
            row++;
            if(row >numFallos-1){
              if(!win == true){
                endGameText = "Game Over";
                win = false;
                ShowResults();
              }


            }

          }

        }


      }else if(s == "BACK"){

        if(indx>5*(row+1)-5){
          indx--;
          entrys.removeLast();
        }

      }else{

        if(indx<5*(row+1)){
          entrys.add(Tile(letter: s, state: AnswerStates.notAnswered));
          indx++;
        }

      }

      Provider.of<GameController>(context, listen: false).notifyListeners();
    }



    return Stack(
      alignment: Alignment.topCenter,
      children:[
        Scaffold(
        appBar: AppBar(
          title: const Text("Wordle"),
          backgroundColor: Color(0xFFFF8600),
          centerTitle: true,
          elevation: 0,

        ),
        body: Column(

          children: [

            Expanded(flex: 7,
                child: Container(color:Colors.white,
                child: const WordGrid(),
                )),

            Expanded(flex: 4,
                child: Container(color:Colors.white,
                child: Column(
                  children: [
                    KBRow(minNum:1, maxNum: 10,onpressed: keyEnter,),
                    KBRow(minNum:11, maxNum: 19,onpressed: keyEnter,),
                    KBRow(minNum:20, maxNum:29,onpressed: keyEnter,),
                  ],
                )

                ))
          ],
        ),
      ),ConfettiWidget(
          confettiController: controllerConfetti,
          numberOfParticles: 20,
          emissionFrequency: 0.1,
          shouldLoop: true,
          blastDirection: pi/2,
        ),]
    );
  }
}


