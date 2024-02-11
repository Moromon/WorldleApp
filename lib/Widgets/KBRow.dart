import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/Game/GameController.dart';
import 'package:wordle_app/Game/answerStates.dart';
import 'package:wordle_app/Game/colors.dart';

import '../Game/GlobalVariables.dart';

class KBRow extends StatelessWidget {
  const KBRow({required this.minNum,required this.maxNum, required this.onpressed(String s),
    super.key,
  });



  final int minNum, maxNum;
  final Function(String val) onpressed;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    Color changeColor(AnswerStates state){
      switch(state){
        case AnswerStates.correct:
          return correct;
        case AnswerStates.contains:
          return wrongPos;
        case AnswerStates.incorrect:
          return wrong;
        case AnswerStates.notAnswered:
          return notUsed;
      }
    }

    return Consumer<GameController>(

      builder: (_,entrys,__) {
        int index = 0;
        return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keysMap.entries.map((e) {
        index++;
        if(index>=minNum && index <=maxNum){
          Color color = changeColor(e.value);
          return Padding(
            padding:  EdgeInsets.all(size.width*0.007),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                  width: e.key == 'ENTER' || e.key == 'BACK' ?
                    size.width *0.13 : size.width*0.085,
                  height: size.height*0.090,
                  child: Material(
                    color: color,
                    child: InkWell(
                        onTap: (){onpressed(e.key);},
                        child: Center(child: Text(e.key,style: TextStyle(color: Colors.white),))),
                  )),
            ),
          );
         }else {
          return const SizedBox();
        }
        }).toList()
      );
      },
    );
  }
}

