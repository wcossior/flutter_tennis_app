import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/models/set_model.dart';
import 'package:flutter_app_tenis/providers/game_provider.dart';

class GameRepository {
  final GameProvider gameProvider = GameProvider();

  Future<List<Game>> getGames(String id, String typeInfo) => gameProvider.getGames(id, typeInfo);
  Future<String> updateScores(String idPartido, int scoreJug1, int scoreJug2) =>
      gameProvider.updateScores(idPartido, scoreJug1, scoreJug2);

  Future<String> newSet(int idPartido, int scoreJug1, int scoreJug2, String nroSet) =>
      gameProvider.newSet(idPartido, scoreJug1, scoreJug2, nroSet);

  Future<String> updateSet(int scoreJug1, int scoreJug2, String nroSet, int idSet) =>
      gameProvider.updateSet(scoreJug1, scoreJug2, nroSet, idSet);
      
  Future<String> deleteSet(int idSet) => gameProvider.deleteSet(idSet);
  Future<List<TennisSet>> getSets(String idPartido) => gameProvider.getSets(idPartido);
}
