import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/Game/GameController.dart';
import 'package:wordle_app/Game/GlobalVariables.dart';
import 'package:wordle_app/Game/answerStates.dart';
import 'package:wordle_app/Game/colors.dart';



class TileWidget extends StatefulWidget {
  const TileWidget({required this.index,
    super.key,
  });
  final int index;

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> with SingleTickerProviderStateMixin {


  Color color = Colors.transparent;
  late AnswerStates state;

  late AnimationController animationController;
  bool doAnim= false;

  changeColor(){
    switch(state){
      case AnswerStates.correct:
        color = correct;
        break;
      case AnswerStates.contains:
        color = wrongPos;
        break;
      case AnswerStates.incorrect:
        color = wrong;
        break;
      case AnswerStates.notAnswered:
        color = empty;
       break;
    }
  }

  @override
  void initState(){
    animationController = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder:(_,notifier,__) {
      String text = "";
      if(widget.index < entrys.length) {
        text = entrys[widget.index].letter;
        state = entrys[widget.index].state;
        if(notifier.lineDone) {
          Future.delayed(Duration(milliseconds: 200),(){
            animationController.forward();
            notifier.lineDone = false;
          });

          changeColor();

        }
        return AnimatedBuilder(
          animation: animationController,
          builder: (_,child) {
            double amount = 0;
            if(animationController.value>0.5){
              amount = pi;
            }
            return Transform(
              alignment: Alignment.center,
            transform: Matrix4.identity()..rotateX(animationController.value*pi)..rotateX(amount),
            child: Container(

              decoration: BoxDecoration(
                color: amount>0 ? color:Colors.transparent,
                border: Border.all(
                  color: Colors.black
                )
              ),

                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(text)),
              ),
          );
          },
        );
      }else{
        return const SizedBox();
      }
    });

  }
}