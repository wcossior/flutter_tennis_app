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
    numero = json["numero"].toString();
    horaInicio = formatDate(json["hora_inicio"]);
    torneoId = json["torneo_id"];
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
