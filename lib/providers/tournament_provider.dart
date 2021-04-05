import 'package:flutter_app_tenis/models/tournament_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TournamentProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<List<Tournament>> getTournament() async {
    final url = Uri.https(_url, "/torneos");

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final tournaments = new Tournaments.fromJsonList(decodeData);

    return tournaments.items;
  }
}
