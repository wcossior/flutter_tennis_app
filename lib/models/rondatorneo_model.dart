import 'package:intl/intl.dart';

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
  String soloFecha;

  RondaTorneo({
    this.id,
    this.numero,
    this.horaInicio,
    this.torneoId,
  });

  RondaTorneo.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    numero = json["numero"].toString();
    horaInicio = formatDate(json["hora_inicio"]);
    soloFecha = formatOnlyDate(json["hora_inicio"]);
    torneoId = json["torneo_id"];
  }

  String formatOnlyDate(String dateWithoutFormat){
    DateTime date = DateTime.parse(dateWithoutFormat);
    String day = date.day.toString();
    String month = getNameMonthToEsp(date.month);
    String nameDay = DateFormat('EEEE').format(date);
    String dayEsp = getNameDayToEsp(nameDay);

    String formatedDate = "$dayEsp $day de $month";

    return formatedDate;
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
