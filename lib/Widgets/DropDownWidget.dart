import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Game/GlobalVariables.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {

  void saveDif() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('intFallos', numFallos);
  }



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DropdownMenu<int>(

      initialSelection: numFallos,
      textStyle: TextStyle(fontSize: 20),

      onSelected: (int? value) {
        // This is called when the user selects an item.
        setState(() {
          numFallos = value!;
          saveDif();
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<int>>((int value) {

        return DropdownMenuEntry<int>(value: value, label: value.toString());
      }).toList(),
    );
  }
}
