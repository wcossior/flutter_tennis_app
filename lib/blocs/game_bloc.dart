import 'package:flutter_app_tenis/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/repositories/game_repository.dart';

class GameBloc extends Validators {
  GameRepository repository = GameRepository();
  List<Game> allGames = [];

  final BehaviorSubject<List<Game>> _gameController = BehaviorSubject<List<Game>>();
  Observable<List<Game>> get streamGame => _gameController.stream;
  Function(List<Game>) get sinkGame => _gameController.sink.add;

  final BehaviorSubject<String> _messageController = BehaviorSubject<String>();
  Observable<String> get streamMessage => _messageController.stream;
  Function(String) get sinkMessage => _messageController.sink.add;
  final PublishSubject _controllerLoading = PublishSubject<bool>();

  Observable<bool> get streamLoading => _controllerLoading.stream;
  String get valueMessage => _messageController.value;

  void dispose() {
    _gameController.close();
    _messageController.close();
    _controllerLoading.close();
  }

  void getGames(String idCategory, String typeInfo) async {
    List<Game> data = await repository.getGames(idCategory, typeInfo);
    sinkGame(data);
    allGames = data;
  }
  Future<Game> getAGame(String idCategory, String idPartido, String typeInfo) async {
    Game data = await repository.getAGame(idCategory, idPartido, typeInfo);
    return data;
  }

  Future updateScores(String idPartido, List<dynamic> marcador) async {
    _controllerLoading.sink.add(true);
    String data = await repository.updateScores(idPartido, marcador);
    sinkMessage(data);
    _controllerLoading.sink.add(false);
  }
  Future fullTime(String idPartido, List<dynamic> marcador) async {
    _controllerLoading.sink.add(true);
    String data = await repository.fullTime(idPartido, marcador);
    sinkMessage(data);
    _controllerLoading.sink.add(false);
  }

  void filterGames(String text) {
    text = text.toLowerCase();
    if (text != "") {
      List<Game> dataGamesForDisplay = allGames.where((game) {
        var gamePlayer1 = game.jug1.toLowerCase();
        var gamePlayer2 = game.jug2.toLowerCase();

        return gamePlayer1.contains(text) || gamePlayer2.contains(text);
      }).toList();
      sinkGame(dataGamesForDisplay);
    } else {
      sinkGame(allGames);
    }
  }
}
