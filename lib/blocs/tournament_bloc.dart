import 'package:flutter_app_tenis/models/tournament_model.dart';
import 'package:flutter_app_tenis/repositories/tournament_repository.dart';
import 'package:rxdart/rxdart.dart';

class TournamentBloc {
  TournamentRepository repository = TournamentRepository();

  final BehaviorSubject<List<Tournament>> _tournament = BehaviorSubject<List<Tournament>>();
  Observable<List<Tournament>> get tournament => _tournament.stream;
  Function(List<Tournament>) get changeTournament => _tournament.sink.add;

  void dispose() {
    _tournament.close();
  }

  void getTournament() async {
    List<Tournament> data = await repository.getTournament();
    changeTournament(data);
  }
}
