import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/repositories/scheduling_repository.dart';
import 'package:rxdart/rxdart.dart';

class SchedulingBloc {
  SchedulingRepository repository = SchedulingRepository();
  List<Event> schedulingAllEvents = [];
  List<String> hours = [];

  final BehaviorSubject<List<Event>> _schedulingController = BehaviorSubject<List<Event>>();
  Observable<List<Event>> get streamScheduling => _schedulingController.stream;
  Function(List<Event>) get sinkScheduling => _schedulingController.sink.add;

  void dispose() {
    _schedulingController.close();
  }

  void getScheduling(String idTournament) async {
    List<Event> data = await repository.getScheduling(idTournament);
    sinkScheduling(data);
    schedulingAllEvents = data;
    getHoursTitle();
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

  void getHoursTitle(){ 
    for (var event in schedulingAllEvents) {
      if(!hours.contains(event.hora)){
        hours.add(event.hora);
      }
    }
  }
}
