import 'package:flutter_app_tenis/models/rondatorneo_model.dart';
import 'package:flutter_app_tenis/providers/rondatorneos_provider.dart';

class RondaTorneosRepository {
  final RondaTorneosProvider rondaTorneosProvider = RondaTorneosProvider();

  Future<List<RondaTorneo>> getRondaTorneos(idTournament) =>
      rondaTorneosProvider.getRondaTorneos(idTournament);
}
