class RondaTorneos {
  List<RondaTorneo> items = [];
  RondaTorneos();
  RondaTorneos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final ronda = new RondaTorneo.fromJsonMap(item);
      items.add(ronda);
    }
  }
}

class RondaTorneo {
  String id;
  String numero;
  String horaInicio;
  String torneoId;

  RondaTorneo({
    this.id,
    this.numero,
    this.horaInicio,
    this.torneoId,
  });

  RondaTorneo.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    numero = json["numero"];
    horaInicio = json["hora_inicio"];
    torneoId = json["torneo_id"];
  }
}
