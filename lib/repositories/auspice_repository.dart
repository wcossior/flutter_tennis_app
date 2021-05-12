import 'dart:io';
import 'package:flutter_app_tenis/models/auspice_model.dart';
import 'package:flutter_app_tenis/providers/auspice_provider.dart';

class AuspiceRepository {
  static final AuspiceRepository _instancia = new AuspiceRepository._internal();

  factory AuspiceRepository() {
    return _instancia;
  }

  AuspiceRepository._internal();

  List<Auspice> list = [];
  final AuspiceProvider auspiceProvider = AuspiceProvider();

  Future getAuspices(String id) async {
    List<Auspice> resp = await auspiceProvider.getAuspices(id);
    list = resp;
  }
  List<Auspice> get auspices => list;

  Future<String> addAuspice(Auspice auspice, File img) => auspiceProvider.addAuspice(auspice, img);
  Future<String> deleteAuspice(String id, String urlImg) => auspiceProvider.deleteAuspice(id, urlImg);

}
