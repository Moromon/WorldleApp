import 'package:flutter/material.dart';
import 'package:wordle_app/Game/GlobalVariables.dart';

import 'TileWidget.dart';

class WordGrid extends StatelessWidget {
  const WordGrid({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.fromLTRB(36, 80, 36, 20),

        itemCount: infiniteMode ? 100000:(numFallos*5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount:5
        ),
        itemBuilder: (context,index){
          return Container(decoration: BoxDecoration(
            border: Border.all()
          ),
            child: TileWidget(index: index,),);
        }
    );
  }
}
