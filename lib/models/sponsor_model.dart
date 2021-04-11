

class Sponsors {
  List<Sponsor> items =[];
  Sponsors();
  Sponsors.fromJsonList(List<dynamic> list) {
    if (list == null) return;
    for (var item in list) {
      final sponsor = new Sponsor.fromJsonMap(item);
      items.add(sponsor);
    }
  }
}

class Sponsor {
  String auspiciante;
  int idTorneo;
  String nombreImg;
  String urlImg;
  String id;

  Sponsor({
    this.auspiciante,
    this.idTorneo,
    this.nombreImg,
    this.urlImg,
    this.id,
  });

  Sponsor.fromJsonMap(dynamic item) {
    auspiciante = item["auspiciante"];
    idTorneo = item["id_torneo"];
    nombreImg = item["nombre_img"];
    urlImg = item["url_img"];
    id = item.documentID;
  }
}
