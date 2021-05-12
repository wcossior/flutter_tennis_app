import 'package:flutter_app_tenis/models/set_model.dart';
import 'package:flutter_app_tenis/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/repositories/game_repository.dart';

class GameBloc extends Validators {
  GameRepository repository = GameRepository();
  List<Game> allGames = [];
  int scoreJugador1;
  int scoreJugador2;

  final BehaviorSubject<List<Game>> _gameController = BehaviorSubject<List<Game>>();
  Observable<List<Game>> get streamGame => _gameController.stream;
  Function(List<Game>) get sinkGame => _gameController.sink.add;

  final BehaviorSubject<List<TennisSet>> _setTennisController = BehaviorSubject<List<TennisSet>>();
  Observable<List<TennisSet>> get streamSetTennis => _setTennisController.stream;
  Function(List<TennisSet>) get sinkSetTennis => _setTennisController.sink.add;

  final BehaviorSubject<String> _messageController = BehaviorSubject<String>();
  Observable<String> get streamMessage => _messageController.stream;
  Function(String) get sinkMessage => _messageController.sink.add;

  final BehaviorSubject<String> _score1Controller = BehaviorSubject<String>();
  final BehaviorSubject<String> _score2Controller = BehaviorSubject<String>();
  final BehaviorSubject<String> _nroSetController = BehaviorSubject<String>();
  final PublishSubject _controllerLoading = PublishSubject<bool>();

  Stream<String> get streamScore1 => _score1Controller.stream;
  Stream<String> get streamScore2 => _score2Controller.stream;
  Stream<String> get streamNroSet => _nroSetController.stream;

  Observable<bool> get streamLoading => _controllerLoading.stream;

  Function(String) get sinkScore1 => _score1Controller.sink.add;
  Function(String) get sinkScore2 => _score2Controller.sink.add;
  Function(String) get sinkNroSet => _nroSetController.sink.add;
  String get valueMessage => _messageController.value;
  String get valueScore1 => _score1Controller.value;
  String get valueScore2 => _score2Controller.value;

  void dispose() {
    _gameController.close();
    _messageController.close();
    _score1Controller.close();
    _score2Controller.close();
    _nroSetController.close();
    _controllerLoading.close();
    _setTennisController.close();
  }

  void getGames(String idCategory, String typeInfo) async {
    List<Game> data = await repository.getGames(idCategory, typeInfo);
    sinkGame(data);
    allGames = data;
  }

  Future updateScores(String idPartido, int scoreJug1, int scoreJug2) async {
    _controllerLoading.sink.add(true);
    String data = await repository.updateScores(idPartido, scoreJug1, scoreJug2);
    sinkMessage(data);
    _controllerLoading.sink.add(false);
  }

  Future updateSet(int idSet) async {
    _controllerLoading.sink.add(true);
    int scoreJug1 = int.parse(_score1Controller.value);
    int scoreJug2 = int.parse(_score2Controller.value);
    String nroSet = _nroSetController.value;
    String data = await repository.updateSet(scoreJug1, scoreJug2, nroSet, idSet);
    sinkMessage(data);
    _controllerLoading.sink.add(false);
  }

  Future newSet(String idPartido) async {
    _controllerLoading.sink.add(true);
    int idGame = int.parse(idPartido);
    int scoreJug1 = int.parse(_score1Controller.value);
    int scoreJug2 = int.parse(_score2Controller.value);
    String nroSet = _nroSetController.value;
    String data = await repository.newSet(idGame, scoreJug1, scoreJug2, nroSet);
    sinkMessage(data);
    _controllerLoading.sink.add(false);
  }

  Future deleteSet(int idSet) async {
    _controllerLoading.sink.add(true);
    String data = await repository.deleteSet(idSet);
    sinkMessage(data);
    _controllerLoading.sink.add(false);
  }

  void getSets(String idPartido) async {
    List<TennisSet> data = await repository.getSets(idPartido);
    sinkSetTennis(data);
  }

  Future getGeneralResult(String idPartido) async{
    _controllerLoading.sink.add(true);
    List<TennisSet> data = _setTennisController.value;
    int scoreJug1 = 0;
    int scoreJug2 = 0;

    for (TennisSet item in data) {
      if (item.scoreJug1 > item.scoreJug2) scoreJug1++;
      if (item.scoreJug2 > item.scoreJug1) scoreJug2++;
    }
    scoreJugador1=scoreJug1;
    scoreJugador2=scoreJug2;
    
    await updateScores(idPartido, scoreJug1, scoreJug2);
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
