import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/scheduling_bloc.dart';
import 'package:flutter_app_tenis/pages/scheduling_page.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class SchedulingByCategoriesPage extends StatefulWidget {
  final String idTournament;
  const SchedulingByCategoriesPage({Key key, this.idTournament}) : super(key: key);

  @override
  _SchedulingByCategoriesPageState createState() => _SchedulingByCategoriesPageState();
}

class _SchedulingByCategoriesPageState extends State<SchedulingByCategoriesPage> {
  SchedulingBloc schedulingBloc = SchedulingBloc();

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
      body: StreamBuilder(
          stream: schedulingBloc.streamScheduling,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.all(SizeConfig.screenWidth * 0.045),
                itemBuilder: (ctx, index) {
                  return _drawCategory(schedulingBloc.categories[index + 1]);
                },
                itemCount: schedulingBloc.categories.length - 1,
              );
            }
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text("No hay programación"));
            }
          }),
    );
  }

  Widget _drawCategory(String category) {
    return ListTile(
      leading: SvgIconsApp.racket,
      title: Text(
        category,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Icon(
        Icons.arrow_right,
        color: ColorsApp.blueObscured,
      ),
      subtitle: Text("Categoría",
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50)),
      selected: true,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SchedulingPage(
              idTournament: widget.idTournament, category: category, options: schedulingBloc.listOptions, scheduling: schedulingBloc.listEvents, 
            ),
          ),
        );
      },
    );
  }
}
