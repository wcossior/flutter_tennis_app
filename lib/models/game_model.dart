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
  String rondaTorneoId;
  String marcador;
  String nroCancha;
  bool partidoTerminado;

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
    this.rondaTorneoId,
    this.marcador,
    this.nroCancha,
    this.partidoTerminado,
  });

  Game.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    nombre = json["nombre"] ?? "";
    etapa = json["etapa"] ?? "";
    horaInicio = json["hora_inicio"]!=null ? formatDate(json["hora_inicio"]) : "Sin definir";
    horaInicioMv = json["hora_inicio_mv"]!=null ? formatDate(json["hora_inicio_mv"]) : "Sin definir";
    horaFin = json["hora_fin"]!=null ? formatDate(json["hora_fin"]) : "Sin definir";
    jugadorUnoId = json["jugador_uno_id"];
    jugadorDosId = json["jugador_dos_id"];
    jug1 = json["jug1"];
    jug2 = json["jug2"];
    rondaTorneoId = json["ronda_torneo_id"];
    marcador = json["marcador"] ?? "Sin definir";
    nroCancha = json["numero_cancha"].toString() ?? "Sin definir";
    partidoTerminado = json["partido_terminado"]?? false;
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
