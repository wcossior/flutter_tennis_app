import 'package:flutter_app_tenis/models/rondatorneo_model.dart';
import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/repositories/rondatorneos_repository.dart';
import 'package:flutter_app_tenis/repositories/scheduling_repository.dart';
import 'package:rxdart/rxdart.dart';

class SchedulingBloc {
  SchedulingRepository repository = SchedulingRepository();
  RondaTorneosRepository repositoryRonda = RondaTorneosRepository();
  List<Event> schedulingAllEvents = [];
  List<String> hours = [];

  final BehaviorSubject<List<Event>> _schedulingController = BehaviorSubject<List<Event>>();
  Observable<List<Event>> get streamScheduling => _schedulingController.stream;
  Function(List<Event>) get sinkScheduling => _schedulingController.sink.add;
 
  final BehaviorSubject<List<RondaTorneo>> _rondasController = BehaviorSubject<List<RondaTorneo>>();
  Observable<List<RondaTorneo>> get streamRondas => _rondasController.stream;
  Function(List<RondaTorneo>) get sinkRondas => _rondasController.sink.add;

  void dispose() {
    _schedulingController.close();
    _rondasController.close();
  }

  void getScheduling(String idTournament) async {
    List<Event> data = await repository.getScheduling(idTournament);
    sinkScheduling(data);
    schedulingAllEvents = data;
  }
  void getRondaTorneos(String idTournament) async {
    List<RondaTorneo> data = await repositoryRonda.getRondaTorneos(idTournament);
    sinkRondas(data);
  }

  void filterEvents(String text) {
    text = text.toLowerCase();
    if (text != "") {
      List<Event> dataGamesForDisplay = schedulingAllEvents.where((event) {
        var eventPlayer1 = event.jugador1.toLowerCase();
        var eventPlayer2 = event.jugador2.toLowerCase();

        return eventPlayer1.contains(text) || eventPlayer2.contains(text);
      }).toList();
      sinkScheduling(dataGamesForDisplay);
    } else {
      sinkScheduling(schedulingAllEvents);
    }
  }
}
