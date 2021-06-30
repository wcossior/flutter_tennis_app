import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/scheduling_bloc.dart';
import 'package:flutter_app_tenis/models/rondatorneo_model.dart';
import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/widgets/customSurfixIcon.dart';
import 'package:flutter_app_tenis/widgets/schedulingCard.dart';

class SchedulingPage extends StatefulWidget {
  final String idTournament;
  const SchedulingPage({Key key, this.idTournament}) : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  SchedulingBloc schedulingBloc = SchedulingBloc();
  String currentOption = 'Todo';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    schedulingBloc.getRondaTorneos(widget.idTournament);
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
        children: [_drawContent(), _drawNoSearchResults()],
      ),
    );
  }

  Widget _drawNoSearchResults() {
    return StreamBuilder(
      stream: schedulingBloc.streamScheduling,
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
        ? Column(
            children: [
              StreamBuilder(
                stream: schedulingBloc.streamScheduling,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      maxLength: 20,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Search.svg"),
                        labelText: "Buscador",
                        hintText: 'Nombre del jugador',
                      ),
                      onChanged: (text) {
                        schedulingBloc.filterEvents(text);
                        if (text == "") {
                          setState(() {
                            currentOption = "Todo";
                          });
                          schedulingBloc.noFilterEventsByDate();
                        }
                      },
                    ),
                  );
                },
              ),
              StreamBuilder(
                  stream: schedulingBloc.streamOptions,
                  builder: (context, snapshot) {
                    List<String> options = snapshot.data;
                    if (options != null && options.isNotEmpty) {
                      return DropdownButton(
                        items: options.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: currentOption,
                        onChanged: (selectedItem) {
                          setState(() {
                            currentOption = selectedItem;
                          });
                          schedulingBloc.filterEventsByDate(currentOption);
                          if (searchController.text != "" && selectedItem == "Todo")
                            schedulingBloc.filterEvents(searchController.text);
                        },
                      );
                    } else {
                      return Container();
                    }
                  })
            ],
          )
        : Container();
  }

  Widget _drawContent() {
    return StreamBuilder(
      stream: schedulingBloc.streamScheduling,
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
        ? Center(child: Text("No hay programación"))
        : ListView.builder(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.055,
              right: SizeConfig.screenWidth * 0.055,
              top: SizeConfig.screenHeight * 0.025,
            ),
            itemBuilder: (ctx, index) {
              return index == 0 ? _searchBar() : _drawCard(data[index - 1]);
            },
            itemCount: data.length + 1,
          );
  }

  Widget _drawCard(Event event) {
    return Column(
      children: [_drawHour(event), SchedulingCard(event: event)],
    );
  }

  Widget _drawHour(Event event) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
        ),
        color: ColorsApp.blueObscured,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIconsApp.clock,
          SizedBox(width: 6.0),
          Text(
            '${event.horaInicio}',
            style: event.horaInicioMviborita == "Se mantiene"
                ? Theme.of(context).textTheme.subtitle2
                : Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }
}
