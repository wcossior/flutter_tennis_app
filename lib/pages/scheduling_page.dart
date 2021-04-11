import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/scheduling_bloc.dart';
import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/widgets/custom_surfix_icon.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SchedulingPage extends StatefulWidget {
  final String idTournament;
  const SchedulingPage({Key key, this.idTournament}) : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  SchedulingBloc schedulingBloc = SchedulingBloc();

  @override
  void initState() {
    schedulingBloc.getScheduling(widget.idTournament);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programación", style: Theme.of(context).textTheme.subtitle2),
      ),
      body: Stack(
        children: [_drawContent(), _drawNoResults()],
      ),
    );
  }

  Widget _drawNoResults() {
    return StreamBuilder(
      stream: schedulingBloc.scheduling,
      builder: (context, snapshot) {
        if (schedulingBloc.schedulingAllEvents.isNotEmpty && snapshot.data.isEmpty) {
          return Center(child: Text("Sin resultados"));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _searchBar() {
    return schedulingBloc.schedulingAllEvents.isNotEmpty
        ? StreamBuilder(
            stream: schedulingBloc.scheduling,
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
                    schedulingBloc.filterEvents(text);
                  },
                ),
              );
            },
          )
        : Container();
  }

  Widget _drawContent() {
    return StreamBuilder(
      stream: schedulingBloc.scheduling,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _drawEvents(snapshot.data);
        }
      },
    );
  }

  Widget _drawEvents(List<Event> data) {
    return data.isEmpty && schedulingBloc.schedulingAllEvents.isEmpty
        ? Center(child: Text("No hay partidos"))
        : ListView.builder(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.055,
              right: SizeConfig.screenWidth * 0.055,
              top: SizeConfig.screenHeight * 0.025,
            ),
            itemBuilder: (ctx, index) {
              return index == 0 ? _searchBar() : _getEvents(data[index - 1]);
            },
            itemCount: data.length + 1,
          );
  }

  Widget _getEvents(Event event) {
    return StickyHeader(
      header: Container(
        height: 50.0,
        color: ColorsApp.blueObscured,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            '${event.hora}',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
      content: Card(
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18.0)),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: _drawInfoCard(event),
      ),
    );
  }

  Widget _drawInfoCard(Event event) {
    return Column(
      children: [
        _drawHeaderCard(event),
        Divider(thickness: 1.2, color: ColorsApp.greyObscured),
        SizedBox(height: getProportionateScreenHeight(8.0)),
        _drawPlayers(event),
        SizedBox(height: getProportionateScreenHeight(8.0)),
      ],
    );
  }

  Widget _drawPlayers(Event event) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(8.0),
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
        bottom: getProportionateScreenWidth(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SvgIconsApp.avatarPlayer,
              SizedBox(height: 6.0),
              Text(
                _getNamePlayer(event.jugador1),
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SvgIconsApp.rackets,
          Column(
            children: [
              SvgIconsApp.avatarPlayer,
              SizedBox(height: 6.0),
              Text(
                _getNamePlayer(event.jugador2),
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawHeaderCard(Event event) {
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
            event.categoria,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "Cancha " + event.cancha,
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
          ),
        ],
      ),
    );
  }

  String _getNamePlayer(String name) {
    if (name.length > 16) {
      return name.substring(0, 17) + "...";
    } else {
      return name;
    }
  }
}
