import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/models/tournament_model.dart';
import 'package:flutter_app_tenis/pages/categories_page.dart';
import 'package:flutter_app_tenis/pages/schedulingByCategories_page.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class TournamentCard extends StatelessWidget {
  final Tournament tournam;

  const TournamentCard({Key key, this.tournam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18.0)),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Column(
          children: [
            _drawHeadCard(tournam, context),
            _drawBodyCard(tournam, context),
          ],
        ),
      );
  }

  Container _drawBodyCard(Tournament tournam,BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(12.0),
        vertical: getProportionateScreenHeight(15.0),
      ),
      child: Column(
        children: [
          _drawInfoTournament(tournam, context),
          Divider(thickness: 1.2, color: ColorsApp.greyObscured),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _drawOptionScheduling(tournam.id, context),
              _drawOptionCategories(tournam.id, context),
            ],
          )
        ],
      ),
    );
  }

  Row _drawOptionCategories(String idTournament,BuildContext context) {
    return Row(
      children: [
        SvgIconsApp.category,
        SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryPage(
                idTournament: idTournament,
              ),
            ),
          ),
          child: Text(
            "Categorías",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        )
      ],
    );
  }

  Row _drawOptionScheduling(String idTournament,BuildContext context) {
    return Row(
      children: [
        SvgIconsApp.schedule,
        SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SchedulingByCategoriesPage(
                idTournament: idTournament,
              ),
            ),
          ),
          child: Text(
            "Programación",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }

  IntrinsicHeight _drawInfoTournament(Tournament tournam, BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          _drawStartDate(tournam, context),
          VerticalDivider(thickness: 1.2, color: ColorsApp.greyObscured),
          _drawEndDate(tournam, context),
          VerticalDivider(thickness: 1.2, color: ColorsApp.greyObscured),
          _drawNumberCourts(tournam, context),
        ],
      ),
    );
  }

  Expanded _drawNumberCourts(Tournament tournam,BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(10.0)),
        child: Row(
          children: [
            SvgIconsApp.court,
            SizedBox(width: 8.0),
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

  Expanded _drawEndDate(Tournament tournam,BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(10.0)),
        child: Row(
          children: [
            SvgIconsApp.calendarEnd,
            SizedBox(width: 8.0),
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

  Expanded _drawStartDate(Tournament tournam,BuildContext context) {
    return Expanded(
      child: Container(
        //se puso paddin porque no funciona el align de row
        padding: EdgeInsets.only(left: getProportionateScreenWidth(10.0)),
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

  Container _drawHeadCard(Tournament tournam,BuildContext context) {
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
          SvgIconsApp.winners,
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