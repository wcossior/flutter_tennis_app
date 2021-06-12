import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/providers/game_provider.dart';

class GameRepository {
  final GameProvider gameProvider = GameProvider();

  Future<List<Game>> getGames(String id, String typeInfo) => gameProvider.getGames(id, typeInfo);

  Future<Game> getAGame(String idCategoria, String idPartido, String typeInfo) =>
      gameProvider.getAGame(idCategoria, idPartido, typeInfo);

  Future<String> updateScores(String idPartido, List<dynamic> marcador) =>
      gameProvider.updateScores(idPartido, marcador);

  Future<String> fullTime(String idPartido, List<dynamic> marcador) =>
      gameProvider.fullTime(idPartido, marcador);
}
