class TennisSets {
  List<TennisSet> items = [];
  TennisSets();
  TennisSets.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final setTennis = new TennisSet.fromJsonMap(item);
      items.add(setTennis);
    }
  }
}

class TennisSet {
  int id;
  int idPartido;
  int scoreJug1;
  int scoreJug2;
  String nroSet;

  TennisSet({
    this.id,
    this.idPartido,
    this.scoreJug1,
    this.scoreJug2,
    this.nroSet,
  });

  TennisSet.fromJsonMap(Map<String, dynamic> json) {
    id = int.parse(json["id"]) ;
    idPartido = int.parse(json["id_partido"]);
    scoreJug1 = json["score_jug_1"];
    scoreJug2 = json["score_jug_2"];
    nroSet = json["nro_set"];
  }
}
