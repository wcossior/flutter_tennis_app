import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<List<Game>> getGames(String idCategory, String typeInfo) async {
    final url = Uri.https(_url, "/$typeInfo/$idCategory");

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final games = new Games.fromJsonList(decodeData);

    return games.items;
  }
}