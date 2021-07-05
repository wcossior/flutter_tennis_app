import 'package:intl/intl.dart';

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
  String cancha;
  String categoria;
  String horaInicio;
  String horaInicioMviborita;
  String horaFin;
  String jugador1;
  String rondaTorneoId;
  String jugador2;
  bool partidoTerminado;

  Event({
    this.id,
    this.cancha,
    this.categoria,
    this.horaInicio,
    this.horaInicioMviborita,
    this.horaFin,
    this.jugador1,
    this.rondaTorneoId,
    this.jugador2,
    this.partidoTerminado,
  });

  Event.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    cancha = json["numero_cancha"].toString();
    categoria = json["nombre"];
    horaInicio =  formatDate(json["hora_inicio"]);
    horaInicioMviborita = json["hora_inico_mv"]!=null ? formatDate(json["hora_inico_mv"]) : "Se mantiene";
    horaFin = json["hora_fin"]!=null ? formatDate(json["hora_fin"]) : "Sin definir";
    jugador1 = json["jug1"];
    rondaTorneoId = json["ronda_torneo_id"];
    jugador2 = json["jug2"];
    partidoTerminado = json["partido_terminado"]??false;
  }

    String formatDate(String dateWithoutFormat) {
    DateTime date = DateTime.parse(dateWithoutFormat);
    String day = date.day.toString();
    String month = getNameMonthToEsp(date.month);
    String nameDay = DateFormat('EEEE').format(date);
    String dayEsp = getNameDayToEsp(nameDay);
    String hour = date.hour.toString();
    String minutes = date.minute.toString();
    if (date.hour < 10) {
      hour = "0" + hour;
    }
    if (date.minute < 10) {
      minutes = "0" + minutes;
    }

    String formatedDate = "$dayEsp $day de $month, $hour:$minutes";

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

    String getNameDayToEsp(String dayEng) {
    String dayEsp;

    switch (dayEng) {
      case "Monday":
        dayEsp = "Lunes";
        break;
      case "Tuesday":
        dayEsp = "Martes";
        break;
      case "Wednesday":
        dayEsp = "Miércoles";
        break;
      case "Thursday":
        dayEsp = "Jueves";
        break;
      case "Friday":
        dayEsp = "Viernes";
        break;
      case "Saturday":
        dayEsp = "Sabado";
        break;
      case "Sunday":
        dayEsp = "Domingo";
        break;
    }
    return dayEsp;
  }
}
