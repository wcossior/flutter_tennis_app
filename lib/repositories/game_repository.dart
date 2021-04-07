import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/providers/game_provider.dart';

class GameRepository {
  final GameProvider gameProvider = GameProvider();

  Future<List<Game>> getGames(String id, String typeInfo) => gameProvider.getGames(id, typeInfo);
}
