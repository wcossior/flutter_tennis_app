import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/repositories/game_repository.dart';

class GameBloc {
  GameRepository repository = GameRepository();

  final BehaviorSubject<List<Game>> _game = BehaviorSubject<List<Game>>();
  Observable<List<Game>> get game => _game.stream;
  Function(List<Game>) get changeGame => _game.sink.add;

  void dispose() {
    _game.close();
  }

  void getGames(String idCategory, String typeInfo) async {
    List<Game> data = await repository.getGames(idCategory, typeInfo);
    changeGame(data);
  }
}
