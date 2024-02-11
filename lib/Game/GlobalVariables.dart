
import 'package:audioplayers/audioplayers.dart';
import 'package:wordle_app/Game/answerStates.dart';

AudioPlayer player = AudioPlayer();

int cont = 0;

List<String> canciones = ["song2.mp3","song1.mp3","song3.mp3"];

List<Tile> entrys = [];

Map<String, AnswerStates> keysMap = {
  "Q"  : AnswerStates.notAnswered,
  "W"  : AnswerStates.notAnswered,
  "E"  : AnswerStates.notAnswered,
  "R"  : AnswerStates.notAnswered,
  "T"  : AnswerStates.notAnswered,
  "Y"  : AnswerStates.notAnswered,
  "U"  : AnswerStates.notAnswered,
  "I"  : AnswerStates.notAnswered,
  "O"  : AnswerStates.notAnswered,
  "P"  : AnswerStates.notAnswered,
  "A"  : AnswerStates.notAnswered,
  "S"  : AnswerStates.notAnswered,
  "D"  : AnswerStates.notAnswered,
  "F"  : AnswerStates.notAnswered,
  "G"  : AnswerStates.notAnswered,
  "H"  : AnswerStates.notAnswered,
  "J"  : AnswerStates.notAnswered,
  "K"  : AnswerStates.notAnswered,
  "L"  : AnswerStates.notAnswered,
  "ENTER"  : AnswerStates.notAnswered,
  "Z"  : AnswerStates.notAnswered,
  "X"  : AnswerStates.notAnswered,
  "C"  : AnswerStates.notAnswered,
  "V"  : AnswerStates.notAnswered,
  "B"  : AnswerStates.notAnswered,
  "N"  : AnswerStates.notAnswered,
  "M"  : AnswerStates.notAnswered,
  "BACK"  : AnswerStates.notAnswered,
};

Map<String, AnswerStates> keysMapBase = {
  "Q"  : AnswerStates.notAnswered,
  "W"  : AnswerStates.notAnswered,
  "E"  : AnswerStates.notAnswered,
  "R"  : AnswerStates.notAnswered,
  "T"  : AnswerStates.notAnswered,
  "Y"  : AnswerStates.notAnswered,
  "U"  : AnswerStates.notAnswered,
  "I"  : AnswerStates.notAnswered,
  "O"  : AnswerStates.notAnswered,
  "P"  : AnswerStates.notAnswered,
  "A"  : AnswerStates.notAnswered,
  "S"  : AnswerStates.notAnswered,
  "D"  : AnswerStates.notAnswered,
  "F"  : AnswerStates.notAnswered,
  "G"  : AnswerStates.notAnswered,
  "H"  : AnswerStates.notAnswered,
  "J"  : AnswerStates.notAnswered,
  "K"  : AnswerStates.notAnswered,
  "L"  : AnswerStates.notAnswered,
  "ENTER"  : AnswerStates.notAnswered,
  "Z"  : AnswerStates.notAnswered,
  "X"  : AnswerStates.notAnswered,
  "C"  : AnswerStates.notAnswered,
  "V"  : AnswerStates.notAnswered,
  "B"  : AnswerStates.notAnswered,
  "N"  : AnswerStates.notAnswered,
  "M"  : AnswerStates.notAnswered,
  "BACK"  : AnswerStates.notAnswered,
};

int numFallos = 5;

bool infiniteMode = false;

const List<int> list = <int>[1,2,3,4,5, 10, 20, 30,40,50];

bool sonido = true;

class Tile{

  Tile({required this.letter, required this.state});

  final String letter;
  AnswerStates state;


}

void SetUpMusic() {
  if (player.state != PlayerState.playing && sonido != false) {
    player.play(AssetSource(canciones[0]));
    player.onPlayerComplete.listen((event) {
      cont++;
      if (cont >= 3) {
        cont = 0;
      }
      player.play(AssetSource(canciones[cont]));
    });
  }else{
    if(player.state == PlayerState.playing){
      player.stop();
    }

  }
}

List<String> words = [];
