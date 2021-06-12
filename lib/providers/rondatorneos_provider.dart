import 'package:flutter_app_tenis/models/rondatorneo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RondaTorneosProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<List<RondaTorneo>> getRondaTorneos(String idTournament) async {
    final url = Uri.https(_url, "/rondatorneos/$idTournament");

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final rondaTorneos = new RondaTorneos.fromJsonList(decodeData);

    return rondaTorneos.items;
  }
}