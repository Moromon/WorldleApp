import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wordle_app/Game/GlobalVariables.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({super.key});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {

  void saveSound() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('boolSound', sonido);
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: sonido,
      activeColor: Color(0xFF8600),

      onChanged: (bool value) {
        setState(() {
           sonido = value;

           saveSound();
           SetUpMusic();
        });
      },
    );
  }
}
