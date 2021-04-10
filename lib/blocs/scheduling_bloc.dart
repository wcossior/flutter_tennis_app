import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/repositories/scheduling_repository.dart';
import 'package:rxdart/rxdart.dart';

class SchedulingBloc {
  SchedulingRepository repository = SchedulingRepository();
  List<Event> schedulingAllEvents = [];

  final BehaviorSubject<List<Event>> _scheduling = BehaviorSubject<List<Event>>();
  Observable<List<Event>> get scheduling => _scheduling.stream;
  Function(List<Event>) get changeScheduling => _scheduling.sink.add;

  void dispose() {
    _scheduling.close();
  }

  void getScheduling(String idTournament) async {
    List<Event> data = await repository.getScheduling(idTournament);
    changeScheduling(data);
    schedulingAllEvents = data;
  }

  void filterEvents(String text) {
    text = text.toLowerCase();
    if (text != "") {
      List<Event> dataGamesForDisplay = schedulingAllEvents.where((event) {
        var eventPlayer1 = event.jugador1.toLowerCase();
        var eventPlayer2 = event.jugador2.toLowerCase();

        return eventPlayer1.contains(text) || eventPlayer2.contains(text);
      }).toList();
      changeScheduling(dataGamesForDisplay);
    } else {
      changeScheduling(schedulingAllEvents);
    }
  }
}
