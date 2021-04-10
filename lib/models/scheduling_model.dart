class Scheduling {
  List<Event> items = [];
  Scheduling();
  Scheduling.fromJsonList(List<dynamic> list) {
    if (list == null) return;
    for (var item in list) {
      final event = new Event.fromJsonMap(item);
      items.add(event);
    }
  }
}

class Event {
  String id;
  String categoria;
  String cancha;
  String hora;
  String jugador1;
  String pertenece1;
  String jugador2;
  String pertenece2;
  String torneoId;

  Event({
    this.id,
    this.categoria,
    this.cancha,
    this.hora,
    this.jugador1,
    this.pertenece1,
    this.jugador2,
    this.pertenece2,
    this.torneoId,
  });

  Event.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    categoria = json["categoria"];
    cancha = json["cancha"];
    hora = json["hora"];
    jugador1 = json["jugador1"];
    pertenece1 = json["pertenece1"];
    jugador2 = json["jugador2"];
    pertenece2 = json["pertenece2"];
    torneoId = json["torneo_id"];
  }
}
