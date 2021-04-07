import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<List<Category>> getCategories(String id) async {
    final url = Uri.https(_url, "/categorias/$id");

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final categories = new Categories.fromJsonList(decodeData);

    return categories.items;
  }
}
