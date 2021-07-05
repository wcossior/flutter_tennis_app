import 'package:intl/intl.dart';

class Tournaments {
  List<Tournament> items = [];
  Tournaments();
  Tournaments.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final tournament = new Tournament.fromJsonMap(item);
      items.add(tournament);
    }
  }
}

class Tournament {
  String id;
  String nombre;
  String fechaInicio;
  String fechaFin;
  String createdAt;
  String updatedAt;
  int numeroCanchas;

  Tournament({
    this.id,
    this.nombre,
    this.fechaInicio,
    this.fechaFin,
    this.createdAt,
    this.updatedAt,
    this.numeroCanchas,
  });

  Tournament.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    nombre = json["nombre"];
    fechaInicio = formatDate(json["fecha_inicio"]);
    fechaFin = formatDate(json["fecha_fin"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    numeroCanchas = json["numero_canchas"];
  }

  String formatDate(String dateWithoutFormat) {
    DateTime date = DateTime.parse(dateWithoutFormat);
    int month = date.month;
    int day = date.day;

    String nameDay = DateFormat('EEEE').format(date);

    String dayEsp = getNameDayToEsp(nameDay);
    String monthEsp = getNameMonthToEsp(month);

    String formatedDate = "$monthEsp $day, $dayEsp";

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
