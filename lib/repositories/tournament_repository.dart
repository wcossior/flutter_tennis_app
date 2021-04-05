import 'package:flutter_app_tenis/models/tournament_model.dart';
import 'package:flutter_app_tenis/providers/tournament_provider.dart';

class TournamentRepository {
  final TournamentProvider tournamentProvider = TournamentProvider();

  Future<List<Tournament>> getTournament() => tournamentProvider.getTournament();
}
