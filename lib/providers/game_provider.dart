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

  Future<Game> getAGame(String idCategory, String idPartido, String typeInfo) async {
    final url = Uri.https(_url, "/$typeInfo/$idCategory/$idPartido");

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final games = new Games.fromJsonList(decodeData);

    return games.items[0];
  }

  Future<String> updateScores(String idPartido, List<dynamic> marcador) async {
    final url = Uri.https(_url, "/actualizarResultado");
    final jsonEncoder = JsonEncoder();
    final marcadorActualizado = {
      "idPartido": idPartido,
      "score": jsonEncoder.convert(marcador),
    };
    final resp = await http.put(url, body: marcadorActualizado);
    final decodeData = json.decode(resp.body);
    return decodeData["msg"];
  }
  Future<String> fullTime(String idPartido, List<dynamic> marcador) async {
    final url = Uri.https(_url, "/partidoTerminado");
    final jsonEncoder = JsonEncoder();
    final marcadorActualizado = {
      "idPartido": idPartido,
      "score": jsonEncoder.convert(marcador),
    };
    final resp = await http.put(url, body: marcadorActualizado);
    final decodeData = json.decode(resp.body);
    return decodeData["msg"];
  }
}
