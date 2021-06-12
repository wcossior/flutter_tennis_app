import 'dart:convert';

class Games {
  List<Game> items = [];
  Games();
  Games.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final gameGroup = new Game.fromJsonMap(item);
      items.add(gameGroup);
    }
  }
}

class Game {
  String id;
  String nombre;
  String etapa;
  String horaInicio;
  String horaInicioMv;
  String horaFin;
  String jugadorUnoId;
  String jugadorDosId;
  String jug1;
  String jug2;
  String club1;
  String club2;
  String rondaTorneoId;
  List<dynamic> marcador = [];
  String ganador;
  String nroCancha;
  bool partidoTerminado;
  int generalScore1 = 0;
  int generalScore2 = 0;

  Game({
    this.id,
    this.nombre,
    this.etapa,
    this.horaInicio,
    this.horaInicioMv,
    this.horaFin,
    this.jugadorUnoId,
    this.jugadorDosId,
    this.jug1,
    this.jug2,
    this.club1,
    this.club2,
    this.rondaTorneoId,
    this.marcador,
    this.nroCancha,
    this.partidoTerminado,
    this.ganador,
    this.generalScore1,
    this.generalScore2,
  });

  Game.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    nombre = json["nombre"] ?? "";
    etapa = json["etapa"] ?? "";
    horaInicio = json["hora_inicio"] != null ? formatDate(json["hora_inicio"]) : "sin definir";
    horaInicioMv = json["hora_inico_mv"] != null ? formatDate(json["hora_inico_mv"]) : "Hora se mantiene";
    horaFin = json["hora_fin"] != null ? formatDate(json["hora_fin"]) : "sin definir";
    jugadorUnoId = json["jugador_uno_id"];
    jugadorDosId = json["jugador_dos_id"];
    jug1 = json["jug1"];
    jug2 = json["jug2"];
    club1 = json["club1"] == "N/A" ? "Sin club" : json["club1"];
    club2 = json["club2"] == "N/A" ? "Sin club" : json["club2"];
    rondaTorneoId = json["ronda_torneo_id"];
    if (json["marcador"] != null) decodeJson(json["marcador"]);
    nroCancha = json["numero_cancha"] == null ? "sin definir" : json["numero_cancha"].toString();
    partidoTerminado = json["partido_terminado"] ?? false;
    if (json["marcador"] != null) ganador = obtenerGanador(json["marcador"]).toString();
  }

  void decodeJson(String data) {
    var mapData = json.decode(data);

    for (var item in mapData) {
      marcador.add(item);
    }
  }

  int obtenerGanador(String data) {
    int marcadorJug1 = 0;
    int marcadorJug2 = 0;
    var mapData = json.decode(data);

    for (var item in mapData) {
      if (item["jugador_uno"] > item["jugador_dos"])
        marcadorJug1++;
      if (item["jugador_uno"] < item["jugador_dos"])
        marcadorJug2++;
    }
    generalScore1 = marcadorJug1;
    generalScore2 = marcadorJug2;

    if (marcadorJug1 > marcadorJug2) {
      return 1;
    } else
      return 2;
  }

  String formatDate(dateWithoutFormat) {
    DateTime date = DateTime.parse(dateWithoutFormat);
    String day = date.day.toString();
    String month = getNameMonthToEsp(date.month);
    String hour = date.hour.toString();
    String minutes = date.minute.toString();
    if (date.hour < 10) {
      hour = "0" + hour;
    }
    if (date.minute < 10) {
      minutes = "0" + minutes;
    }

    String formatedDate = "$day $month, $hour:$minutes";

    return formatedDate;
  }

  String getNameMonthToEsp(int month) {
    List<String> months = [
      "Ene",
      "Feb",
      "Mar",
      "Abr",
      "May",
      "Jun",
      "Jul",
      "Ago",
      "Sep",
      "Oct",
      "Nov",
      "Dic",
    ];
    return months[month - 1];
  }
}
