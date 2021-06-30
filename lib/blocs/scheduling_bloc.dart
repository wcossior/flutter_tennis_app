import 'package:flutter_app_tenis/models/rondatorneo_model.dart';
import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/repositories/rondatorneos_repository.dart';
import 'package:flutter_app_tenis/repositories/scheduling_repository.dart';
import 'package:rxdart/rxdart.dart';

class SchedulingBloc {
  SchedulingRepository repository = SchedulingRepository();
  RondaTorneosRepository repositoryRonda = RondaTorneosRepository();
  List<Event> schedulingAllEvents = [];
  List<Event> schedulingEventsByDate = [];
  List<Event> schedulingEventsByName = [];
  String textOptionDate;
  bool filteredByDate = false;
  bool filteredByName = false;

  final BehaviorSubject<List<Event>> _schedulingController = BehaviorSubject<List<Event>>();
  Observable<List<Event>> get streamScheduling => _schedulingController.stream;
  Function(List<Event>) get sinkScheduling => _schedulingController.sink.add;
  List<Event> get listEvents => _schedulingController.value;

  final BehaviorSubject<List<String>> _optionsController = BehaviorSubject<List<String>>();
  Observable<List<String>> get streamOptions => _optionsController.stream;
  Function(List<String>) get sinkOptions => _optionsController.sink.add;

  void dispose() {
    _schedulingController.close();
    _optionsController.close();
  }

  void getScheduling(String idTournament) async {
    List<Event> data = await repository.getScheduling(idTournament);
    sinkScheduling(data);
    schedulingAllEvents = data;
  }

  void getRondaTorneos(String idTournament) async {
    var optionsDates = await repositoryRonda.getRondaTorneos(idTournament);
    sinkOptions(optionsDates);
  }

  void filterEvents(String text) {
    text = text.toLowerCase();
    if (text != "") {
      List<Event> dataGamesForDisplay;
      if (filteredByDate) {
        dataGamesForDisplay = schedulingEventsByDate.where((event) {
          var eventPlayer1 = event.jugador1.toLowerCase();
          var eventPlayer2 = event.jugador2.toLowerCase();

          return eventPlayer1.contains(text) || eventPlayer2.contains(text);
        }).toList();
      } else {
        dataGamesForDisplay = schedulingAllEvents.where((event) {
          var eventPlayer1 = event.jugador1.toLowerCase();
          var eventPlayer2 = event.jugador2.toLowerCase();

          return eventPlayer1.contains(text) || eventPlayer2.contains(text);
        }).toList();
      }

      schedulingEventsByName = dataGamesForDisplay;
      sinkScheduling(dataGamesForDisplay);
      filteredByName = true;
    } else {
      sinkScheduling(schedulingAllEvents);
      filteredByName = false;
    }
  }

  void noFilterEventsByDate() {
    filteredByDate = false;
  }

  void filterEventsByDate(String text) {
    textOptionDate = text;
    if (text != 'Todo') {
      List<Event> dataGamesForDisplay;
      if (filteredByName) {
        dataGamesForDisplay = schedulingEventsByName.where((event) {
          var horaInicio = event.horaInicio;
          return horaInicio == text;
        }).toList();
      } else {
        dataGamesForDisplay = schedulingAllEvents.where((event) {
          var horaInicio = event.horaInicio;
          return horaInicio == text;
        }).toList();
      }
      schedulingEventsByDate = dataGamesForDisplay;
      sinkScheduling(dataGamesForDisplay);
      filteredByDate = true;
    } else {
      sinkScheduling(schedulingAllEvents);
      filteredByDate = false;
    }
  }
}
