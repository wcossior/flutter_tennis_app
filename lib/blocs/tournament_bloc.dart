import 'package:flutter_app_tenis/models/tournament_model.dart';
import 'package:flutter_app_tenis/repositories/tournament_repository.dart';
import 'package:rxdart/rxdart.dart';

class TournamentBloc {
  TournamentRepository repository = TournamentRepository();

  final BehaviorSubject<List<Tournament>> _tournamentController = BehaviorSubject<List<Tournament>>();
  Observable<List<Tournament>> get streamTournament => _tournamentController.stream;
  Function(List<Tournament>) get sinkTournament => _tournamentController.sink.add;

  void dispose() {
    _tournamentController.close();
  }

  void getTournament() async {
    List<Tournament> data = await repository.getTournament();
    sinkTournament(data);
  }
}
