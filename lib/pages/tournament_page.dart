import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/tournament_bloc.dart';
import 'package:flutter_app_tenis/models/tournament_model.dart';
import 'package:flutter_app_tenis/widgets/tournamentCard.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({Key key}) : super(key: key);

  @override
  _TournamentPageState createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> with AutomaticKeepAliveClientMixin<TournamentPage> {
  TournamentBloc tournBloc = TournamentBloc();
  @override
  void initState() {
    tournBloc.getTournament();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      child: _drawContent(),
    );
  }

  StreamBuilder<List<Tournament>> _drawContent() {
    return StreamBuilder(
      stream: tournBloc.tournament,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return _drawListTournament(snapshot.data);
        }
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No hay torneos"));
        }
      },
    );
  }

  Widget _drawListTournament(List<Tournament> data) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.055),
      children: _drawTournaments(data),
    );
  }

  List<Widget> _drawTournaments(List<Tournament> data) {
    final List<Widget> drawnTournament = [];
    final tournamentsList = data;

    tournamentsList.forEach((tournam) {
      final widgetTemp = TournamentCard(tournam: tournam);
      drawnTournament.add(widgetTemp);
    });
    return drawnTournament;
  }
}
