import 'package:flutter_app_tenis/models/rondatorneo_model.dart';
import 'package:flutter_app_tenis/providers/rondatorneos_provider.dart';

class RondaTorneosRepository {
  List<RondaTorneo> rondas = [];
  List<String> rondasPorFecha = ["Todo"];
  final RondaTorneosProvider rondaTorneosProvider = RondaTorneosProvider();

  Future<List<String>> getRondaTorneos(idTournament) async {
    rondas = await rondaTorneosProvider.getRondaTorneos(idTournament);
    toRondasPorFecha();
    return rondasPorFecha;
  }

  void toRondasPorFecha() {
    // var now = DateTime.now();
    // var today = DateTime(now.year, now.month, now.day);
    for (RondaTorneo item in rondas) {
      var fecha = item.horaInicio;
      rondasPorFecha.add(fecha);
    }
    rondasPorFecha = rondasPorFecha.toSet().toList();
  }
}
