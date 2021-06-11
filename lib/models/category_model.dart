class Categories {
  List<Category> items = [];
  Categories();
  Categories.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final category = new Category.fromJsonMap(item);
      items.add(category);
    }
  }
}

class Category {
  String id;
  String nombre;
  int numeroJugadores;
  int edad;
  int numeroJugadoresGrupo;
  String tipo;
  String torneoId;
  Category({
    this.id,
    this.nombre,
    this.numeroJugadores,
    this.edad,
    this.numeroJugadoresGrupo,
    this.tipo,
    this.torneoId
  });

  Category.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    nombre = json["nombre"];
    numeroJugadores = json["numero_jugadores"];
    edad = json["edad"];
    numeroJugadoresGrupo = json["numero_jugadores_grupo"];
    tipo = json["tipo"]=="roundRobin"? "Round Robin": "Cuadro de avance";
    torneoId = json["torneo_id"];
  }
}
