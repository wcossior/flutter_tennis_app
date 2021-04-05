import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/tournament_bloc.dart';
import 'package:flutter_app_tenis/models/tournament_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({Key key}) : super(key: key);

  @override
  _TournamentPageState createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> with AutomaticKeepAliveClientMixin<TournamentPage> {
  TournamentBloc tournBloc = TournamentBloc();
  final key = GlobalKey();
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
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.025),
      child: _drawContent(),
    );
  }

  StreamBuilder<List<Tournament>> _drawContent() {
    return StreamBuilder(
      stream: tournBloc.tournament,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return _drawTournament(snapshot.data);
        }
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No hay torneos"));
        }
      },
    );
  }

  Widget _drawTournament(List<Tournament> data) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: _getTournaments(data),
    );
  }

  List<Widget> _getTournaments(List<Tournament> data) {
    final List<Widget> drawnTournament = [];
    final tournamentsList = data;

    tournamentsList.forEach((tournam) {
      final widgetTemp = Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Column(
          children: [
            _drawHeadCard(tournam),
            _drawBodyCard(tournam),
          ],
        ),
      );
      drawnTournament.add(widgetTemp);
    });
    return drawnTournament;
  }

  Container _drawBodyCard(Tournament tournam) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(12.0),
        vertical: getProportionateScreenHeight(15.0),
      ),
      child: Column(
        children: [
          _drawInfoTournament(tournam),
          Divider(thickness: 1.2, color: ColorsApp.greyObscured),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _drawOptionPlayoffs(),
              _drawOptionGroups(),
            ],
          )
        ],
      ),
    );
  }

  Row _drawOptionGroups() {
    return Row(
      children: [
        SvgIconsApp.group,
        SizedBox(width: 6.0),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Grupos",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        )
      ],
    );
  }

  Row _drawOptionPlayoffs() {
    return Row(
      children: [
        SvgIconsApp.playoffs,
        SizedBox(width: 6.0),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Eliminatorias",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }

  IntrinsicHeight _drawInfoTournament(Tournament tournam) {
    return IntrinsicHeight(
      child: Row(
        children: [
          _drawStartDate(tournam),
          VerticalDivider(thickness: 1.2, color: ColorsApp.greyObscured),
          _drawEndDate(tournam),
          VerticalDivider(thickness: 1.2, color: ColorsApp.greyObscured),
          _drawNumberCourts(tournam),
        ],
      ),
    );
  }

  Expanded _drawNumberCourts(Tournament tournam) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(13.0)),
        child: Row(
          children: [
            SvgIconsApp.court,
            SizedBox(width: 6.0),
            Flexible(
              child: Text(
                "Canchas " + tournam.numeroCanchas.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _drawEndDate(Tournament tournam) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(13.0)),
        child: Row(
          children: [
            SvgIconsApp.calendarEnd,
            SizedBox(width: 6.0),
            Flexible(
              child: Text(
                tournam.fechaFin,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _drawStartDate(Tournament tournam) {
    return Expanded(
      child: Container(
        //se puso paddin porque no funciona el align de row
        padding: EdgeInsets.only(left: getProportionateScreenWidth(13.0)),
        child: Row(
          children: [
            SvgIconsApp.calendarStart,
            SizedBox(width: 6.0),
            Flexible(
              child: Text(
                tournam.fechaInicio,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _drawHeadCard(Tournament tournam) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
        ),
        color: ColorsApp.blueObscured,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(12.0),
        vertical: getProportionateScreenHeight(15.0),
      ),
      width: double.infinity,
      child: Row(
        children: [
          SvgIconsApp.winner,
          SizedBox(width: 12.0),
          Flexible(
            child: Text(
              tournam.nombre,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}