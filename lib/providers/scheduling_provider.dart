import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SchedulingProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<List<Event>> getScheduling(String idTournament) async {
    final url = Uri.https(_url, "/programacion/$idTournament");

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final scheduling = new Scheduling.fromJsonList(decodeData);

    return scheduling.items;
  }
}