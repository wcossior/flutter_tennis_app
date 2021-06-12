import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/models/set_model.dart';
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

  Future<String> updateSet(int scoreJug1, int scoreJug2, String nroSet, int idSet) async {
    final url = Uri.https(_url, "/updateSet");

    final setTennisData = {
      "scoreJug1": scoreJug1.toString(),
      "scoreJug2": scoreJug2.toString(),
      "nroSet": nroSet,
      "idSet": idSet.toString(),
    };
    final resp = await http.put(url, body: setTennisData);
    final decodeData = json.decode(resp.body);
    return decodeData["msg"];
  }

  Future<String> newSet(int idPartido, int scoreJug1, int scoreJug2, String nroSet) async {
    final url = Uri.https(_url, "/newSet");

    final Map setTennisData = {
      "idPartido": idPartido.toString(),
      "scoreJug1": scoreJug1.toString(),
      "scoreJug2": scoreJug2.toString(),
      "nroSet": nroSet,
    };
    final resp = await http.post(url, body: setTennisData);
    final decodeData = json.decode(resp.body);
    return decodeData["msg"];
  }

  Future<String> deleteSet(int idSet) async {
    final url = Uri.https(_url, "/deleteSet/${idSet.toString()}");

    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);
    return decodeData["msg"];
  }
  //partidoTerminado

  Future<List<TennisSet>> getSets(String idPartido) async {
    final url = Uri.https(_url, "/sets/$idPartido");

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final setsTennis = new TennisSets.fromJsonList(decodeData);

    return setsTennis.items;
  }
}
