import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/repositories/game_repository.dart';

class GameBloc {
  GameRepository repository = GameRepository();
  List<Game> allGames = [];

  final BehaviorSubject<List<Game>> _games = BehaviorSubject<List<Game>>();
  Observable<List<Game>> get games => _games.stream;
  Function(List<Game>) get changeGames => _games.sink.add;

  void dispose() {
    _games.close();
  }

  void getGames(String idCategory, String typeInfo) async {
    List<Game> data = await repository.getGames(idCategory, typeInfo);
    changeGames(data);
    allGames = data;
  }

  void filterGames(String text) {
    text = text.toLowerCase();
    if (text != "") {
      List<Game> dataGamesForDisplay = allGames.where((game) {
        var gamePlayer1 = game.jug1.toLowerCase();
        var gamePlayer2 = game.jug2.toLowerCase();

        return gamePlayer1.contains(text) || gamePlayer2.contains(text);
      }).toList();
      changeGames(dataGamesForDisplay);
    } else {
      changeGames(allGames);
    }
  }
}
