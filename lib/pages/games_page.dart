import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/game_bloc.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/pages/detailGame_page.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/utils/keyboard.dart';
import 'package:flutter_app_tenis/widgets/custom_surfix_icon.dart';

class GamesPage extends StatefulWidget {
  final String idCategory;
  final String typeInfo;
  GamesPage({Key key, @required this.idCategory, @required this.typeInfo}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  GameBloc gameBloc = GameBloc();

  @override
  void initState() {
    gameBloc.getGames(widget.idCategory, widget.typeInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partidos", style: Theme.of(context).textTheme.subtitle2),
      ),
      body: Stack(
        children: [_drawContent(), _drawNoResults()],
      ),
    );
  }

  Widget _drawNoResults() {
    return StreamBuilder(
      stream: gameBloc.games,
      builder: (context, snapshot) {
        if (gameBloc.allGames.isNotEmpty && snapshot.data.isEmpty) {
          return Center(child: Text("Sin resultados"));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _searchBar() {
    return gameBloc.allGames.isNotEmpty
        ? StreamBuilder(
            stream: gameBloc.games,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Search.svg"),
                    labelText: "Buscador",
                    hintText: 'Ingrese el nombre del jugador',
                  ),
                  onChanged: (text) {
                    gameBloc.filterGames(text);
                  },
                ),
              );
            },
          )
        : Container();
  }

  Widget _drawContent() {
    return StreamBuilder(
      stream: gameBloc.games,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _drawGames(snapshot.data);
        }
      },
    );
  }

  Widget _drawGames(List<Game> data) {
    return data.isEmpty && gameBloc.allGames.isEmpty
        ? Center(child: Text("No hay partidos"))
        : ListView.builder(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.055,
              right: SizeConfig.screenWidth * 0.055,
              top: SizeConfig.screenHeight * 0.025,
            ),
            itemBuilder: (ctx, index) {
              return index == 0 ? _searchBar() : _getGames(data[index - 1]);
            },
            itemCount: data.length + 1,
          );
  }

  Widget _getGames(Game game) {
    return Card(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18.0)),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: _drawInfoCard(game),
    );
  }

  Widget _drawInfoCard(Game game) {
    return Column(
      children: [
        _drawHeader(game),
        Divider(thickness: 1.2, color: ColorsApp.greyObscured),
        SizedBox(height: getProportionateScreenHeight(8.0)),
        _drawPlayer(game.jug1, game.scoreJugador1, game.scoreJugador2),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        _drawPlayer(game.jug2, game.scoreJugador2, game.scoreJugador1),
        SizedBox(height: getProportionateScreenHeight(8.0)),
        Divider(thickness: 1.2, color: ColorsApp.greyObscured),
        _drawOptionDetails(game),
      ],
    );
  }

  Widget _drawOptionDetails(Game game) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(8.0),
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
        bottom: getProportionateScreenWidth(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIconsApp.detail,
          SizedBox(width: 8.0),
          GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailGamePage(
                    game: game,
                  ),
                ),
              );
            },
            child: Text(
              "Ver detalles",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: ColorsApp.orange,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawPlayer(String name, int score, int anotherScore) {
    if (score > anotherScore) {
      return _drawWinnerPlayer(name, score);
    } else {
      return _drawLoserPlayer(name, score);
    }
  }

  Widget _drawLoserPlayer(String name, int score) {
    return Container(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgIconsApp.avatarPlayer,
              SizedBox(width: 6.0),
              Text(
                _getNamePlayer(name),
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _drawWinnerPlayer(String name, int score) {
    return Container(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgIconsApp.avatarPlayer,
              SizedBox(width: 6.0),
              _drawWinner(name),
            ],
          ),
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget _drawWinner(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _drawWinnerIcon(),
        Text(
          _getNamePlayer(name),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _drawWinnerIcon() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(6.0),
        vertical: getProportionateScreenHeight(3.0),
      ),
      child: Text(
        "Ganó",
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: ColorsApp.white,
              fontSize: 10.0,
            ),
      ),
      decoration: BoxDecoration(
        color: ColorsApp.orange,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  Widget _drawHeader(Game game) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(12.0),
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
        bottom: getProportionateScreenWidth(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _getTitleGame(game),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            game.horaInicio,
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
          ),
        ],
      ),
    );
  }

  String _getTitleGame(Game game) {
    if (game.etapa == "") {
      return "Partido de grupo " + game.nombre;
    } else {
      return "Partido de " + game.etapa;
    }
  }

  String _getNamePlayer(String name) {
    if (name.length > 16) {
      return name.substring(0, 17) + "...";
    } else {
      return name;
    }
  }
}
